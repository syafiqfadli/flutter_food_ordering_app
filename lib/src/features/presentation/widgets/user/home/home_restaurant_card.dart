import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/pages/pages.dart';

class HomeRestaurantCard extends StatelessWidget {
  final int index;
  final RestaurantEntity restaurant;

  const HomeRestaurantCard({
    super.key,
    required this.index,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeMenuPage(
                restaurant: restaurant,
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: AppColor.primaryColor,
              width: 1,
            ),
          ),
          elevation: 3,
          color: AppColor.backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const Icon(Icons.restaurant),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 30,
                    ),
                    child: AutoSizeText(
                      restaurant.restaurantName,
                      minFontSize: 22,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
