import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/utils/utils.dart';

class CartDetailsCard extends StatefulWidget {
  final int index;
  final MenuEntity menu;

  const CartDetailsCard({
    Key? key,
    required this.index,
    required this.menu,
  }) : super(key: key);

  @override
  State<CartDetailsCard> createState() => _CartDetailsCardState();
}

class _CartDetailsCardState extends State<CartDetailsCard> {
  @override
  Widget build(BuildContext context) {
    MenuEntity menu = widget.menu;
    int index = widget.index + 1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: SizedBox(
        height: 150,
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
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColor.secondaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      '$index',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            menu.menu,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          'RM ${menu.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Quantity: ${menu.quantity}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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