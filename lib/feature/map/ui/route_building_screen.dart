import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/feature/map/bloc/routes/routes_cubit.dart';
import 'package:starter/utils/utils.dart';
import 'package:starter/widgets/bottom_sheets/select_routes_bottom_sheet.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class SessionPage extends StatefulWidget {
  const SessionPage({super.key});

  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<SessionPage> {
  @override
  void dispose() {
    super.dispose();

    BlocProvider.of<RoutesCubit>(context).closeSession();
  }

  Point _getPointBetweenMarks() {
    final bloc = BlocProvider.of<RoutesCubit>(context);
    final p1 = (bloc.mapObjects[0] as PlacemarkMapObject).point;
    final p2 = (bloc.mapObjects[1] as PlacemarkMapObject).point;
    return Point(
        latitude: (p1.latitude + p2.latitude) / 2,
        longitude: (p1.longitude + p2.longitude) / 2);
  }

  double _getZoom() {
    return 10.0;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((value) => showBottom());
  }

  showBottom() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        context: context,
        builder: (_) => const SelectRoutesBottomSheet(),
        isScrollControlled: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Выбор маршрута',
          style: AppTypography.font16w400,
        )),
        body: Stack(
          children: [
            SafeArea(
              child: BlocBuilder<RoutesCubit, RoutesState>(
                builder: (context, state) {
                  final bloc = BlocProvider.of<RoutesCubit>(context);

                  return YandexMap(
                    mapObjects: bloc.mapObjects,
                    onMapCreated: (value) {
                      value.moveCamera(CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: _getPointBetweenMarks(),
                              zoom: _getZoom())));
                    },
                  );
                },
              ),
            ),
            SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: showBottom,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black45,
                                    offset: Offset(0, 4),
                                    blurRadius: 8)
                              ]),
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Маршруты',
                                style: AppTypography.font16w400
                                    .copyWith(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
                ))
          ],
        ));
  }
}
