import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:starter/feature/map/bloc/routes/routes_cubit.dart';
import 'package:starter/feature/map/data/map_repository.dart';
import 'package:starter/feature/map/ui/route_building_screen.dart';
import 'package:starter/widgets/map_items/map_button.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../utils/utils.dart';
import '../../../widgets/bottom_sheets/filter_bottom_sheet.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _MainMap();
  }
}

class _MainMap extends StatefulWidget {
  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<_MainMap> {
  late final List<MapObject> mapObjects = [endPlacemark];
  late YandexMapController _controller;
  PlacemarkMapObject endPlacemark = PlacemarkMapObject(
      mapId: const MapObjectId('end_placemark'),
      point: const Point(
          latitude: 55.67479414358153, longitude: 37.27735250601342),
      opacity: 1,
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image:
              BitmapDescriptor.fromAssetImage('assets/images/office_mark.png'),
          scale: .3)));

  void showFiltersBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) => const FiltersBottomSheet(),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(12), topLeft: Radius.circular(12))),
        isScrollControlled: true);
  }

  StreamSubscription? subscription;

  @override
  void dispose() {
    if (subscription != null) {
      subscription!.cancel();
    }
    super.dispose();
  }

  DateTime? lastUserAction;

  void streamSubscription(YandexMapController controller) {
    final repository = RepositoryProvider.of<MapRepository>(context);
    subscription?.cancel();
    subscription ??= repository.stream!.stream.listen((event) async {
      final lastPos = await controller.getCameraPosition();
      if (Geolocator.distanceBetween(lastPos.target.latitude,
                  lastPos.target.longitude, event.lat, event.long) >
              20 &&
          DateTime.now()
                  .difference(lastUserAction ?? DateTime(2000))
                  .inSeconds >
              7) {
        repository.moveToCurrentLocation(event, controller);
        setState(() {
          if (mapObjects.length > 1) {
            mapObjects.removeAt(0);
          }
          mapObjects.insert(
              0,
              PlacemarkMapObject(
                  mapId: const MapObjectId('me'),
                  point: event.toPoint(),
                  opacity: 1,
                  icon: PlacemarkIcon.single(PlacemarkIconStyle(
                    image: BitmapDescriptor.fromAssetImage(
                        'assets/images/Location.png'),
                    scale: 1,
                  ))));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<MapRepository>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Карта',
              style: AppTypography.font20w600,
            ),
            Image.asset(
              'assets/images/VTB_logo-white_ru.png',
              height: 25,
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                      flex: 6,
                      child: YandexMap(
                        onMapCreated: (controller) {
                          _controller = controller;
                          repository.futureLatLong!.then((value) {
                            streamSubscription(controller);
                          });
                        },
                        onCameraPositionChanged: (position, reason, f) {
                          if (reason == CameraUpdateReason.gestures) {
                            lastUserAction = DateTime.now();
                          }
                          print(
                              '${position.target.latitude} ${position.target.longitude} ${position.zoom}');
                        },
                        mapObjects: mapObjects,
                      )),
                ]),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  const SizedBox(
                    width: double.infinity,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MapButton.icon(onTap: () {
                        repository.moveToCurrentLocation(null, _controller);
                      }, asset: Icons.location_searching),
                      const SizedBox(width: 10),
                      MapButton.withSuffixIcon(onTap: showFiltersBottomSheet, text: 'Фильтры', asset: Icons.filter_list_outlined),
                      const SizedBox(width: 10),
                      MapButton.text(onTap: _requestRoutes, text: 'Построить маршрут')
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _requestRoutes() async {
    final startPoint =
        (await RepositoryProvider.of<MapRepository>(context).futureLatLong!)
            .toPoint();

    BlocProvider.of<RoutesCubit>(context).getRoutes(
        start: PlacemarkMapObject(mapId: MapObjectId('me'), point: startPoint),
        end: endPlacemark);

    await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => SessionPage()));
  }
}
