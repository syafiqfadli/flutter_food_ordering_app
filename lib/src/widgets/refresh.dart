import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/utils/utils.dart';

class CustomRefresh extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final bool Function(ScrollNotification) predicate;

  final Widget child;

  const CustomRefresh({
    Key? key,
    required this.onRefresh,
    required this.child,
    required this.predicate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      backgroundColor: AppColor.primaryColor,
      color: AppColor.secondaryColor,
      displacement: 1,
      notificationPredicate: predicate,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
