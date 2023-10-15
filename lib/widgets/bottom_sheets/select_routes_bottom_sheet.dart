import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/feature/map/bloc/routes/routes_cubit.dart';
import 'package:starter/feature/map/ui/navigator.dart';
import 'package:starter/utils/utils.dart';
import 'package:starter/widgets/buttons/custom_button.dart';
import 'package:starter/widgets/map_items/route.dart';

class SelectRoutesBottomSheet extends StatelessWidget {
  const SelectRoutesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<RoutesCubit, RoutesState>(
        builder: (context, state) {
          if (state is RoutesFoundedState) {
            List<Widget> children = [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Маршруты',
                  style: AppTypography.font16w400.copyWith(color: Colors.black),
                ),
              ),
            ];
            final bloc = BlocProvider.of<RoutesCubit>(context);
            for (int i = 0; i < bloc.result!.routes!.length; i++) {
              children.add(RouteItem(
                onTap: () {
                  bloc.changeRoute(i);
                },
                name:
                    'Время пути: ${bloc.result!.routes![i].metadata.weight.timeWithTraffic.text}',
                active: bloc.currentRoute == i,
              ));
            }
            children.add(CustomButton(
              text: 'Поехали',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const NavigatorScreen()));
              },
              width: double.infinity,
              isActive: true,
            ));

            return Column(mainAxisSize: MainAxisSize.min, children: children);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    ));
  }
}
