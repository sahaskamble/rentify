import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// Handles location permission requests and settings
class LocationPermissionHandler {
  /// Request location permission with user-friendly dialogs
  static Future<LocationPermission> requestLocationPermission(
    BuildContext context,
  ) async {
    try {
      // Check if location services are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (context.mounted) {
          await _showLocationDisabledDialog(context);
        }
        return LocationPermission.denied;
      }

      // Check current permission status
      var permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          if (context.mounted) {
            await _showPermissionDeniedDialog(context);
          }
          return LocationPermission.denied;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (context.mounted) {
          await _showPermissionDeniedForeverDialog(context);
        }
        return LocationPermission.deniedForever;
      }

      return permission;
    } catch (e) {
      return LocationPermission.denied;
    }
  }

  /// Dialog when location services are disabled
  static Future<void> _showLocationDisabledDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Location Services Disabled'),
        content: const Text(
          'Please enable location services in your device settings to use location-based features.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Geolocator.openLocationSettings();
              Navigator.pop(ctx);
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  /// Dialog when permission is denied
  static Future<void> _showPermissionDeniedDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Location Permission'),
        content: const Text(
          'Rentify needs your location to show nearby rentals and help you find items close to you.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Not Now'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await Geolocator.requestPermission();
            },
            child: const Text('Allow'),
          ),
        ],
      ),
    );
  }

  /// Dialog when permission is permanently denied
  static Future<void> _showPermissionDeniedForeverDialog(
    BuildContext context,
  ) async {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Location Permission'),
        content: const Text(
          'Location permission is permanently denied. Please enable it in app settings to use location features.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Geolocator.openAppSettings();
              Navigator.pop(ctx);
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }
}
