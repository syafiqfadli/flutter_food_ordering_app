import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/utils/utils.dart';

class CornerDesign extends StatelessWidget {
  const CornerDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: Container(
            color: AppColor.backgroundColor,
            height: 100,
            width: 100,
          ),
        ),
        Positioned(
          top: 5,
          left: 5,
          child: Container(
            color: AppColor.secondaryColor,
            height: 90,
            width: 90,
          ),
        )
      ],
    );
  }
}
