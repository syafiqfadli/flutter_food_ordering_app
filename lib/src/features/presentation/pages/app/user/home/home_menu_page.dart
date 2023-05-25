import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class HomeMenuPage extends StatelessWidget {
  final RestaurantEntity restaurant;

  const HomeMenuPage({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return BaseUserApp(
      title: restaurant.restaurantName.toUpperCase(),
      isMainPage: false,
      child: Expanded(
        child: restaurant.menuList.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 160,
                ),
                itemCount: restaurant.menuList.length,
                itemBuilder: (context, index) => HomeMenuCard(
                  menu: restaurant.menuList[index],
                  restaurant: restaurant,
                ),
              )
            : ListView(
                children: const [
                  Center(
                    child: Text("No menu yet."),
                  ),
                ],
              ),
      ),
    );
  }
}
