import 'package:flutter/material.dart';
import 'package:starter/utils/utils.dart';

class OfficeContainer extends StatelessWidget {
  const OfficeContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 115,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black45, offset: Offset(0, 4), blurRadius: 4)
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/burger.png',
            fit: BoxFit.fitHeight,
          ),
          Column(
            children: [
              SizedBox(
                width: MediaQuery
                    .sizeOf(context)
                    .width * 200 / 370,
                child: Text(
                  'Отделение где-то в ебенях',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.fon14w400.copyWith(color: Colors.black),
                ),
              ),
              SizedBox(width: MediaQuery
                  .sizeOf(context)
                  .width * 200 / 370,
                child: Text('подзалупинская 69',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.fon12w400.copyWith(
                      color: Colors.grey),),
              )
            ],
          )
        ],
      ),
    );
  }
}
