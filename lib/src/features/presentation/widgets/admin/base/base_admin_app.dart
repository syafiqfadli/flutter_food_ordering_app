import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class BaseAdminApp extends StatelessWidget {
  final String title;
  final bool isMainPage;
  final RestaurantEntity? restaurant;
  final Widget child;

  const BaseAdminApp({
    super.key,
    required this.title,
    required this.isMainPage,
    this.restaurant,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              AdminAppHeader(
                title: title,
                isMainPage: isMainPage,
                restaurant: restaurant,
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
