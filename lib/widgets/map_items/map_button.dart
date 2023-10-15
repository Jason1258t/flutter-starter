import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

class MapButton extends StatelessWidget {
  const MapButton({super.key, required this.onTap, this.child});

  MapButton.withSuffixIcon(
      {super.key,
      required this.onTap,
      required String text,
      required IconData asset})
      : child = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: AppTypography.font16w400.copyWith(color: Colors.black),
            ),
            const SizedBox(
              width: 8,
            ),
            Icon(
              asset,
              color: Colors.black,
              size: 20,
            )
          ],
        );

  MapButton.icon({super.key, required this.onTap, required IconData asset})
      : child = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              asset,
              color: Colors.black,
              size: 20,
            )
          ],
        );

  MapButton.text({super.key, required this.onTap, required String text})
      : child = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: AppTypography.font16w400.copyWith(color: Colors.black),
            )
          ],
        );

  final VoidCallback onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black45, offset: Offset(0, 4), blurRadius: 8)
              ]),
          padding: const EdgeInsets.all(8),
          child: child),
    );
  }
}
