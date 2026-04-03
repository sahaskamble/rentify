import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rentify/services/location_service.dart';

final locationServiceProvider = Provider((ref) => LocationService());

/// Location state model
class LocationState {
  final double? lat;
  final double? lng;
  final String city;
  final String area;
  final bool isLoading;
  final String? errorMessage;

  const LocationState({
    this.lat,
    this.lng,
    this.city = '',
    this.area = '',
    this.isLoading = false,
    this.errorMessage,
  });

  bool get hasLocation => lat != null && lng != null;

  String get displayAddress =>
      [area, city].where((s) => s.isNotEmpty).join(', ');

  LocationState copyWith({
    double? lat,
    double? lng,
    String? city,
    String? area,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LocationState(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      city: city ?? this.city,
      area: area ?? this.area,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// Location notifier for managing location state
class LocationNotifier extends AsyncNotifier<LocationState> {
  static const _latKey = 'location_lat';
  static const _lngKey = 'location_lng';
  static const _cityKey = 'location_city';
  static const _areaKey = 'location_area';

  SharedPreferences? _prefs;

  @override
  Future<LocationState> build() async {
    _prefs = await SharedPreferences.getInstance();
    return _loadSavedLocation();
  }

  /// Load location from shared preferences
  LocationState _loadSavedLocation() {
    final lat = _prefs?.getDouble(_latKey);
    final lng = _prefs?.getDouble(_lngKey);
    final city = _prefs?.getString(_cityKey) ?? '';
    final area = _prefs?.getString(_areaKey) ?? '';

    if (lat != null && lng != null) {
      return LocationState(lat: lat, lng: lng, city: city, area: area);
    }

    return const LocationState();
  }

  /// Save location to shared preferences
  Future<void> _saveLocation(
    double lat,
    double lng,
    String city,
    String area,
  ) async {
    await _prefs?.setDouble(_latKey, lat);
    await _prefs?.setDouble(_lngKey, lng);
    await _prefs?.setString(_cityKey, city);
    await _prefs?.setString(_areaKey, area);
  }

  /// Fetch current location from GPS
  Future<void> fetchCurrentLocation() async {
    state = const AsyncValue.loading();

    try {
      final locationService = ref.read(locationServiceProvider);

      // Get GPS coordinates
      final position = await locationService.getCurrentLocation();

      // Get address from coordinates
      final placemark = await locationService.getAddressFromCoords(
        position.latitude,
        position.longitude,
      );

      // Extract city and area
      final addressData = placemark != null
          ? locationService.extractCityAndArea(placemark)
          : {'city': '', 'area': ''};

      final city = addressData['city'] ?? '';
      final area = addressData['area'] ?? '';

      // Save to shared preferences
      await _saveLocation(position.latitude, position.longitude, city, area);

      // Update state
      state = AsyncValue.data(
        LocationState(
          lat: position.latitude,
          lng: position.longitude,
          city: city,
          area: area,
        ),
      );
    } on LocationServiceDisabledException {
      state = AsyncValue.error(
        'Location services are disabled. Please enable them in settings.',
        StackTrace.current,
      );
    } on PermissionDeniedException catch (e) {
      state = AsyncValue.error(
        e.toString().contains('forever')
            ? 'Location permission permanently denied. Open app settings.'
            : 'Location permission denied',
        StackTrace.current,
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Set location manually
  Future<void> setManualLocation(String city, String area) async {
    try {
      // Get current state to extract lat/lng
      final currentLocation = state.maybeWhen(
        data: (data) => data,
        orElse: () => const LocationState(),
      );

      final lat = currentLocation.lat ?? 0.0;
      final lng = currentLocation.lng ?? 0.0;

      // Save to shared preferences
      await _saveLocation(lat, lng, city, area);

      // Update state
      state = AsyncValue.data(
        LocationState(lat: lat, lng: lng, city: city, area: area),
      );
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Clear location
  Future<void> clearLocation() async {
    await _prefs?.remove(_latKey);
    await _prefs?.remove(_lngKey);
    await _prefs?.remove(_cityKey);
    await _prefs?.remove(_areaKey);

    state = const AsyncValue.data(LocationState());
  }
}

/// Riverpod provider for location state
final locationProvider = AsyncNotifierProvider<LocationNotifier, LocationState>(
  LocationNotifier.new,
);
