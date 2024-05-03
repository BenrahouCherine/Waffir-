import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GeoLocationService extends GetxService {
  final box = GetStorage();
  StreamSubscription<Position>? _positionStreamSubscription;

  Map<String, dynamic>? get locationData => box.read('location');

  @override
  void onInit() {
    super.onInit();
    _requestPermissionsAndSaveLocation();
    startListeningLocationChanges();
  }

  Future<void> _requestPermissionsAndSaveLocation() async {
    try {
      Map<String, dynamic> locationData = await determinePosition();
      box.write('location', locationData);
    } catch (e) {
      printError(info: 'Failed to get location: $e');
    }
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];

    return {
      'longitude': position.longitude,
      'latitude': position.latitude,
      'city': place.locality,
      'country': place.country,
    };
  }

  void startListeningLocationChanges() {
    _positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.medium,
      distanceFilter: 10,
    )).listen((Position position) async {
      // Get the place from the coordinates
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      // Save the location data
      Map<String, dynamic> locationData = {
        'latitude': position.latitude,
        'longitude': position.longitude,
        'country': place.country,
        'city': place.locality,
      };
      box.write('location', locationData);

      printInfo(info: 'LAST SAVED LOCATION: ${locationData.toString()}');
    });
  }

  void stopListeningLocationChanges() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription!.cancel();
      _positionStreamSubscription = null;
    }
  }

  @override
  void onClose() {
    stopListeningLocationChanges();
    super.onClose();
  }
}
