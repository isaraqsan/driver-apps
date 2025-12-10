import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:gibas/core/utils/location_usecase.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/features/home/controller/home_controller.dart';
import 'package:gibas/shared/widgets/overlay/overlay_controller.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

enum OrderStep { idle, accepted, pickedUp, delivering, finished }

class OrderDetailController extends GetxController {
  final LocationUseCase locationUseCase = LocationUseCase();

  OrderStep step = OrderStep.idle;
  LatLng? driverLocation;
  LatLng? _lastDriverLocation;

  List<LatLng> route = [];
  bool isGettingLocation = false;
  LatLng? _currentTarget;

  StreamSubscription<Position>? locationSub;
  final MapController mapController = MapController();
  bool isAutoFollow = true;
  String? pickUpPhoto; // path atau base64
  String? deliverPhoto;
  File? selectedFile;
  late OrderItem item;

  @override
  void onInit() {
    super.onInit();
    // Tangkap argument
    item = Get.arguments as OrderItem;

    // Ambil lokasi awal tanpa menunggu
    _initDriverLocation();
  }

  Future<void> _initDriverLocation() async {
    final pos = await locationUseCase.getCurrentLocation();
    if (pos != null) {
      driverLocation = LatLng(pos.latitude, pos.longitude);
      _lastDriverLocation = driverLocation;

      // Bisa langsung hitung route ke pickup
      _currentTarget = LatLng(item.pickupLat, item.pickupLong);
      try {
        route = await fetchRoute(driverLocation!, _currentTarget!);
      } catch (e) {
        Log.e("Failed to fetch initial route: $e");
      }

      update(); // trigger rebuild map
    }
  }

  @override
  void onClose() {
    locationSub?.cancel();
    super.onClose();
  }

  // =============================
  // STEP 1 : AMBIL ORDER
  // =============================
  Future<void> takeOrder(LatLng target) async {
    step = OrderStep.accepted;
    update();

    await _startTracking(target);
  }

  // =============================
  // STEP 2 : PICK UP
  // =============================
  void pickUp() async {
    step = OrderStep.pickedUp;
    Log.d('Order picked up, step updated to: $step');
    update();

    // ganti target ke drop-off
    if (driverLocation != null) {
      _currentTarget = LatLng(item.dropLat, item.dropLong);
      await updateRoute(_currentTarget!);
      update();
    }
  }

  // =============================
  // STEP 3 : ANTAR
  // =============================
  void deliver() async {
    step = OrderStep.delivering;
    update();

    // clear route setelah drop-off (optional)
    route = [];
    update();
  }

  Future<void> uploadPickUpPhoto(String path) async {
    pickUpPhoto = path;
    step = OrderStep.pickedUp;
    Log.d('Pick up photo uploaded, step updated to: $step');
    update();
  }

  Future<void> uploadDeliverPhoto(String path) async {
    deliverPhoto = path;
    step = OrderStep.delivering;
    update();
  }

  // =============================
  // STEP 4 : FINISH
  // =============================
  void finishOrder() {
    step = OrderStep.finished;
    locationSub?.cancel();
    update();
  }

  // =============================
  // TRACK DRIVER LOCATION + UPDATE ROUTE
  // =============================
  Future<void> _startTracking(LatLng target) async {
    _currentTarget = target; // simpan target saat ini
    await locationSub?.cancel();

    final pos = await locationUseCase.getCurrentLocation();
    if (pos != null) {
      driverLocation = LatLng(pos.latitude, pos.longitude);
      _lastDriverLocation = driverLocation;
      await updateRoute(_currentTarget!); // load initial route
      update();
    }

    locationSub = locationUseCase.watchLocation().listen((pos) async {
      final newLoc = LatLng(pos.latitude, pos.longitude);

      double rotation = mapController.camera.rotation;
      if (_lastDriverLocation != null) {
        rotation = _calculateBearing(_lastDriverLocation!, newLoc);
      }

      driverLocation = newLoc;
      _lastDriverLocation = newLoc;

      if (isAutoFollow) {
        mapController.moveAndRotate(
          newLoc,
          mapController.camera.zoom,
          rotation,
        );
      }

      // update route ke target saat ini
      if (_currentTarget != null) await updateRoute(_currentTarget!);

      update();
    });
  }

  // =============================
  // HITUNG BEARING
  // =============================
  double _calculateBearing(LatLng? from, LatLng to) {
    if (from == null) return 0;

    final lat1 = from.latitude * (3.1415926535 / 180);
    final lat2 = to.latitude * (3.1415926535 / 180);
    final dLon = (to.longitude - from.longitude) * (3.1415926535 / 180);

    final y = Math.sin(dLon) * Math.cos(lat2);
    final x = Math.cos(lat1) * Math.sin(lat2) -
        Math.sin(lat1) * Math.cos(lat2) * Math.cos(dLon);

    final brng = Math.atan2(y, x);

    return (brng * 180 / 3.1415926535 + 360) % 360;
  }

  // =============================
  // FETCH ROUTE DARI OSRM PUBLIC
  // =============================
  Future<List<LatLng>> fetchRoute(LatLng start, LatLng end) async {
    final url =
        'http://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final coords = data['routes'][0]['geometry']['coordinates'] as List;

      return coords
          .map((point) => LatLng(point[1] as double, point[0] as double))
          .toList();
    } else {
      throw Exception('Failed to load route');
    }
  }

  // =============================
  // UPDATE ROUTE KE TARGET
  // =============================
  Future<void> updateRoute(LatLng target) async {
    if (driverLocation == null) return;
    try {
      route = await fetchRoute(driverLocation!, target);
    } catch (e) {
      Log.e("Failed to fetch route: $e");
    }
  }

  Future<void> refreshLocation() async {
    if (isGettingLocation) return;
    isGettingLocation = true;
    OverlayController().showLoading();
    update();

    try {
      final pos = await locationUseCase.getCurrentLocation();
      if (pos != null) {
        driverLocation = LatLng(pos.latitude, pos.longitude);
        Log.d('Refreshed location: $driverLocation');
        _lastDriverLocation = driverLocation;

        if (isAutoFollow) {
          mapController.move(driverLocation!, mapController.camera.zoom);
        }

        update();
      }
    } finally {
      isGettingLocation = false;
      update();
      OverlayController().hide();
    }
  }
}
