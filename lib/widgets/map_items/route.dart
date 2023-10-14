import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

class RouteItem extends StatelessWidget {
  const RouteItem(
      {super.key,
      required this.onTap,
      required this.name,
      required this.active});

  final VoidCallback onTap;
  final String name;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: active ? AppColors.selectedWayColor : Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black45, offset: Offset(0, 4), blurRadius: 4)
          ],
        ),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(10),
        child: Text(
          name,
          style: AppTypography.fon14w400.copyWith(color: Colors.black),
        ),
      ),
    );
  }
}
