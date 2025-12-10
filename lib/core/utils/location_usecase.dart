import 'package:geolocator/geolocator.dart';

class LocationUseCase {
  /// Cek permission
  Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission == LocationPermission.always ||
           permission == LocationPermission.whileInUse;
  }

  /// Ambil posisi driver saat ini
  Future<Position?> getCurrentLocation() async {
    final allowed = await checkPermission();
    if (!allowed) return null;

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  /// Stream lokasi (realtime)
  Stream<Position> watchLocation() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // update per 5 meter
      ),
    );
  }
}
