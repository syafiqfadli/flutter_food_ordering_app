import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/pages/app/cart_details_page.dart';
import 'package:flutter_food_ordering_app/src/utils/utils.dart';

class CartCard extends StatelessWidget {
  final int index;
  final CartEntity cart;

  const CartCard({super.key, required this.index, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CartDetailsPage(
                index: index,
                restaurantName: cart.restaurantName,
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
                const Icon(Icons.shopping_bag_rounded),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 30),
                    child: Text(
                      cart.restaurantName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 35,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
