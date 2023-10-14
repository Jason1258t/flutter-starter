import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starter/utils/utils.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'routes_state.dart';

class RoutesCubit extends Cubit<RoutesState> {
  RoutesCubit() : super(RoutesInitial());

  List<MapObject> mapObjects = [];

  int currentRoute = 0;
  DrivingSessionResult? result;
  DrivingSession? session;

  void getRoutes({
    required PlacemarkMapObject start,
    required PlacemarkMapObject end,
  }) async {
    emit(RoutesLoadingState());
    mapObjects.add(start);
    mapObjects.add(end);
    final resultWithSession = YandexDriving.requestRoutes(
        points: [
          RequestPoint(
              point: start.point, requestPointType: RequestPointType.wayPoint),
          RequestPoint(
              point: end.point, requestPointType: RequestPointType.wayPoint),
        ],
        drivingOptions: const DrivingOptions(
            initialAzimuth: 0, routesCount: 3, avoidTolls: true));

    session = resultWithSession.session;
    result = await resultWithSession.result;

    _addObjects();

    emit(RoutesFoundedState());

  }

  void _addObjects() {
    mapObjects = mapObjects.sublist(0, 2);
    result!.routes!.asMap().forEach((i, route) {
      mapObjects.add(PolylineMapObject(
        mapId: MapObjectId('route_${i}_polyline'),
        polyline: Polyline(points: route.geometry),
        strokeColor: i == currentRoute
            ? AppColors.primary
            : AppColors.border,
        strokeWidth: 3,
      ));
    });
  }


  void changeRoute(int index) {
    currentRoute = index;
    _addObjects();
    emit(RoutesFoundedState());
  }

  void cancel() async {
    if (session != null) {
      await session!.cancel();
    }
  }
  void closeSession() async {
    if (session != null) {
      await session!.close();
      session = null;
      emit(RoutesInitial());
    }
  }
}
