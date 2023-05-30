import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';
import 'package:order_me/src/core/utils/utils.dart';
import 'package:order_me/src/features/presentation/pages/pages.dart';

class HomeMenuCard extends StatelessWidget {
  final MenuEntity menu;
  final RestaurantEntity restaurant;

  const HomeMenuCard({
    super.key,
    required this.menu,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeDetailsPage(
                restaurant: restaurant,
                menu: menu,
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
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoSizeText(
                  menu.menuName,
                  minFontSize: 20,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "RM ${menu.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
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
