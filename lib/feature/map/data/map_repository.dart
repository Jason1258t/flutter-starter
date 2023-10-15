import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:starter/feature/map/data/location_service.dart';
import 'package:starter/models/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapRepository {
  Completer<YandexMapController> mapControllerCompleter =
      Completer<YandexMapController>();

  MapRepository() : super() {
    _initPermission();
  }

  Future<AppLatLong>? futureLatLong;
  BehaviorSubject<AppLatLong>? stream;

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    _fetchCurrentLocation();
    final ls = LocationService();
    ls.initialStream();
    stream = ls.positionStream;
  }

  Future<void> _fetchCurrentLocation() async {
    futureLatLong = LocationService().getCurrentLocation();
  }

  Future<void> moveToCurrentLocation(
    AppLatLong? appLatLong,
    YandexMapController controller,
  ) async {
    appLatLong ??= await LocationService().getCurrentLocation();
    controller.moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
          ),
          zoom: 16,
        ),
      ),
    );
  }
}
