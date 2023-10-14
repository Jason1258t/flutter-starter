import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

class FiltersBottomSheet extends StatefulWidget {
  const FiltersBottomSheet({super.key});

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      height: MediaQuery.sizeOf(context).height * 0.6,
      // decoration: const BoxDecoration(
      //     color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2)),
                margin: const EdgeInsets.only(bottom: 10),
              )
            ],
          ),
          Text(
            'Расстояние',
            style: AppTypography.font16w400.copyWith(color: Colors.black),
          )
        ],
      ),
    );
  }
}
