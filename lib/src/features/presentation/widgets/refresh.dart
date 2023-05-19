import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';

class CustomRefresh extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const CustomRefresh({
    Key? key,
    required this.onRefresh,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColor.primaryColor,
      color: AppColor.secondaryColor,
      displacement: 1,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
