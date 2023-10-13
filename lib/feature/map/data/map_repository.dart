import 'dart:async';

import 'package:flutter/material.dart';
import 'package:starter/feature/map/data/location_service.dart';
import 'package:starter/models/location.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapRepository {
  Completer<YandexMapController> mapControllerCompleter =
      Completer<YandexMapController>();

  MapRepository() : super() {
    _initPermission();
  }

  YandexMap? map;
  Future<AppLatLong>? latLong;

  Future init(List<MapObject<dynamic>> mapObjects) async {
    map ??= YandexMap(
      onMapCreated: (controller) {
        latLong!.then((value) => _moveToCurrentLocation(value, controller));
      },
      mapObjects: mapObjects,
    );
  }

  Future<void> _initPermission() async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    _fetchCurrentLocation();
  }

  Future<void> _fetchCurrentLocation() async {
    latLong = LocationService().getCurrentLocation();
  }

  Future<void> _moveToCurrentLocation(
    AppLatLong appLatLong,
    YandexMapController controller,
  ) async {
    controller.moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 0),
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
