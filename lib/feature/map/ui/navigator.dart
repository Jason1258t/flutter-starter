import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:starter/feature/map/bloc/routes/routes_cubit.dart';
import 'package:starter/feature/map/data/map_repository.dart';
import 'package:starter/utils/utils.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  StreamSubscription? subscription;
  final List<MapObject> mapObjects = [];


  @override
  void dispose() {
    if (subscription != null) {
      subscription!.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    final routesBloc = BlocProvider.of<RoutesCubit>(context);
    final route = routesBloc.result!.routes![routesBloc.currentRoute];
    mapObjects.add(PolylineMapObject(
      mapId: const MapObjectId('route_${0}_polyline'),
      polyline: Polyline(points: route.geometry),
      strokeColor: AppColors.primary,
      strokeWidth: 3,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final repository = RepositoryProvider.of<MapRepository>(context);
    void streamSubscription(YandexMapController controller) {
      final repository = RepositoryProvider.of<MapRepository>(context);
      subscription?.cancel();
      subscription ??= repository.stream!.stream.listen((event) async {
        final lastPos = await controller.getCameraPosition();
        if (Geolocator.distanceBetween(lastPos.target.latitude,
            lastPos.target.longitude, event.lat, event.long) >
            20) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Навигатор', style: AppTypography.font20w600,),
      ),
      body: SafeArea(
        child: YandexMap(
          onMapCreated: (controller) {
            repository.futureLatLong!.then((value) {
              streamSubscription(controller);
            });
          },
          onCameraPositionChanged: (position, reason, f) {
            print(
                '${position.target.latitude} ${position.target.longitude} ${position.zoom}');
          },
          mapObjects: mapObjects,
        )
      ),
    );
  }
}
