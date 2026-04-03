import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

/// LocationService: Handles GPS, geocoding, and location utilities
class LocationService {
  /// Get current device location with permission handling
  Future<Position> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw LocationServiceDisabledException();
      }

      // Check and request permissions
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        throw PermissionDeniedException('Location permission denied');
      }

      if (permission == LocationPermission.deniedForever) {
        throw PermissionDeniedException(
          'Location permission permanently denied. Open app settings to enable.',
        );
      }

      // Get current position with timeout and accuracy settings
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 0,
          timeLimit: Duration(seconds: 15), // 15 second timeout
        ),
      );

      return position;
    } on LocationServiceDisabledException {
      rethrow;
    } on PermissionDeniedException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to get location: ${e.toString()}');
    }
  }

  /// Get address details from latitude and longitude
  Future<Placemark?> getAddressFromCoords(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isEmpty) return null;
      return placemarks.first;
    } catch (e) {
      return null;
    }
  }

  /// Extract city and area from Placemark
  Map<String, String> extractCityAndArea(Placemark placemark) {
    final city = placemark.locality ?? placemark.administrativeArea ?? '';
    final area = placemark.subLocality ?? placemark.thoroughfare ?? '';

    return {'city': city, 'area': area};
  }

  /// Format location display string
  String formatLocationDisplay(String area, String city) {
    final parts = [area, city].where((s) => s.isNotEmpty).toList();
    return parts.join(', ');
  }
}
