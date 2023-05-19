import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class HomeDetailsCard extends StatefulWidget {
  final int index;
  final MenuEntity menu;
  final String restaurantId;
  final String restaurantName;

  const HomeDetailsCard({
    super.key,
    required this.index,
    required this.menu,
    required this.restaurantId,
    required this.restaurantName,
  });

  @override
  State<HomeDetailsCard> createState() => _HomeDetailsCardState();
}

class _HomeDetailsCardState extends State<HomeDetailsCard> {
  TextEditingController quantityController = TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: SizedBox(
        height: 220,
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      '${widget.index + 1}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.menu.menuName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "RM ${widget.menu.price.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const Text("Quantity"),
                      InputQuantity(quantityController: quantityController),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                  ),
                  onPressed: () {
                    _addToCart(
                      width: width,
                      restaurantId: widget.restaurantId,
                      restaurantName: widget.restaurantName,
                      menuId: widget.menu.menuId,
                      menuName: widget.menu.menuName,
                      price: widget.menu.price,
                      quantity: int.parse(quantityController.text),
                    );
                  },
                  child: const Text('Add to Cart'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addToCart({
    required double width,
    required String restaurantId,
    required String restaurantName,
    required String menuId,
    required String menuName,
    required double price,
    required int quantity,
  }) async {
    if (quantity == 0) {
      DialogService.showMessage(
        title: "Quantity Error",
        message: "Please enter valid quantity.",
        icon: Icons.error,
        width: width,
        context: context,
      );

      return;
    }

    await context.read<AddToCartCubit>().addToCart(
          restaurantId: restaurantId,
          restaurantName: restaurantName,
          menuId: menuId,
          menuName: menuName,
          price: price,
          quantity: quantity,
        );
  }
}
