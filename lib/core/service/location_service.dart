import 'dart:convert';

import 'package:gibas/core/app/app_config.dart';
import 'package:gibas/core/app/constant/hive_key.dart';
import 'package:gibas/core/app/controller/auth_controller.dart';
import 'package:gibas/core/service/database_service.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/shared/utils/bottomsheet_helper.dart';
import 'package:gibas/shared/widgets/overlay/overlay_controller.dart';

import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

class LocationService {
  static final LocationService _singleton = LocationService._internal();

  factory LocationService() => _singleton;

  LocationService._internal();

  Future<Position?> determinePosition({
    bool isLoading = false,
    bool cache = false,
  }) async {
    Position? position;

    final databaseService = Get.find<DatabaseService>();

    try {
      if (cache && await isTimeLast()) {
        final String? lastLocation = await databaseService.read(HiveKey.locationLast.key);
        if (lastLocation != null) {
          position = Position.fromMap(jsonDecode(lastLocation));
          AuthController.instance.setLocation(
            LatLng(position.latitude, position.longitude),
          );
          return position;
        }
      }

      if (isLoading) {
        OverlayController.to.showLoading();
      }

      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.back();
        BottomsheetHelper.gpsDisabled();
        return Future.error('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.back(closeOverlays: true);
          BottomsheetHelper.gpsPermissionDenied();
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.back(closeOverlays: true);
        BottomsheetHelper.gpsPermissionDenied();
        return Future.error('Location permissions are permanently denied, we cannot request permissions.');
      }

      position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(
          intervalDuration: AppConfig.timeRequestApi,
          timeLimit: AppConfig.timeRequestApi,
        ),
      );

      if (isLoading) {
        OverlayController.to.hide();
      }

      AuthController.instance.setLocation(
        LatLng(position.latitude, position.longitude),
      );

      await databaseService.write(HiveKey.locationLast.key, jsonEncode(position));

      await databaseService.write(HiveKey.locationLastTime.key, DateTime.now().toString());

      return position;
    } catch (e) {
      if (isLoading) {
        OverlayController.to.hide();
      }

      Utils.toast(e.toString(), snackType: SnackType.error);
      throw Exception(e.toString());
    }
  }

  Future<bool> isGpsActive() async {
    final bool isGpsActive = await Geolocator.isLocationServiceEnabled();
    LocationPermission locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied || locationPermission == LocationPermission.deniedForever || locationPermission == LocationPermission.unableToDetermine) {
      locationPermission = await Geolocator.requestPermission();
    }

    return isGpsActive && (locationPermission == LocationPermission.whileInUse || locationPermission == LocationPermission.always);
  }

  Future<bool> isLocationEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<double> distanceBetween(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) async {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }

  Future<bool> isTimeLast() async {
    final DatabaseService databaseService = Get.find();
    final String lastTimeString = await databaseService.read(HiveKey.locationLastTime.key) ?? DateTime.now().subtract(const Duration(hours: 1)).toString();

    final DateTime lastTime = DateTime.parse(lastTimeString);
    return DateTime.now().difference(lastTime).inMinutes > 10;
  }
}
