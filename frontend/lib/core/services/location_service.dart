import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationResult {
  final double latitude;
  final double longitude;
  final String? cityName;

  const LocationResult({
    required this.latitude,
    required this.longitude,
    this.cityName,
  });

  @override
  String toString() =>
      'LocationResult(lat: $latitude, lng: $longitude, city: $cityName)';
}

class LocationService {
  /// Check and request location permissions, then return the current position
  /// along with the resolved city name.
  Future<LocationResult> getCurrentLocation() async {
    // Check if location services are enabled.
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const LocationServiceException('Location services are disabled.');
    }

    // Check / request permission.
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const LocationServiceException('Location permission denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw const LocationServiceException(
        'Location permissions are permanently denied. '
        'Please enable them in Settings.',
      );
    }

    // Get current position.
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      timeLimit: Duration(seconds: 10),
    );
    final position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    // Reverse-geocode to get city name.
    String? city;
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        city = placemarks.first.locality ?? placemarks.first.subAdministrativeArea;
      }
    } catch (e) {
      debugPrint('LocationService: reverse geocoding failed: $e');
    }

    return LocationResult(
      latitude: position.latitude,
      longitude: position.longitude,
      cityName: city,
    );
  }
}

class LocationServiceException implements Exception {
  final String message;
  const LocationServiceException(this.message);

  @override
  String toString() => 'LocationServiceException: $message';
}
