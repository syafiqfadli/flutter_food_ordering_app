import 'package:flutter/material.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';
import 'package:order_me/src/core/utils/utils.dart';

class RestaurantDetailsCard extends StatelessWidget {
  final int index;
  final RestaurantEntity restaurant;

  const RestaurantDetailsCard({
    super.key,
    required this.index,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: SizedBox(
        height: 100,
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
                Container(
                  padding: const EdgeInsets.all(1),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppColor.secondaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text('${index + 1}'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      restaurant.restaurantName,
                      style: const TextStyle(
                        fontSize: 24,
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
