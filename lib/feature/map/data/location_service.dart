import 'dart:async';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:starter/models/location.dart';

class LocationService {
  final defLocation = const MoscowLocation();

  BehaviorSubject<AppLatLong> positionStream = BehaviorSubject.seeded(const MoscowLocation());

  void initialStream () {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      positionStream.add(await getCurrentLocation());
    });
  }

  Future<AppLatLong> getCurrentLocation() async {
    return Geolocator.getCurrentPosition().then((value) {
      return AppLatLong(lat: value.latitude, long: value.longitude);
    });
  }

  Future<bool> requestPermission() {
    return Geolocator.requestPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
        .then((value) =>
            value == LocationPermission.always ||
            value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }
}
