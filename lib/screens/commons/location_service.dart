// location_service.dart
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Stream<Position> getLocationStream() {
    return Geolocator.getPositionStream(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high));
  }

  // Method to get the driver’s location stream
  Stream<Position> getDriverLocation() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Updates when the driver moves 10 meters
      ),
    );
  }
}
