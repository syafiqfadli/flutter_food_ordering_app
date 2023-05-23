import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class HomeDetailsCard extends StatefulWidget {
  final MenuEntity menu;
  final RestaurantEntity restaurant;

  const HomeDetailsCard({
    super.key,
    required this.menu,
    required this.restaurant,
  });

  @override
  State<HomeDetailsCard> createState() => _HomeDetailsCardState();
}

class _HomeDetailsCardState extends State<HomeDetailsCard> {
  TextEditingController quantityController = TextEditingController(text: "0");
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(5.0),
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
            children: [
              Expanded(
                child: Text(
                  widget.menu.menuName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "RM ${widget.menu.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 16,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              InputQuantity(quantityController: quantityController),
              isClicked
                  ? const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                      ),
                      onPressed: () {
                        _addToCart(
                          width: width,
                          restaurantId: widget.restaurant.restaurantId,
                          restaurantName: widget.restaurant.restaurantName,
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

    setState(() {
      isClicked = true;
    });

    await context.read<AddToCartCubit>().addToCart(
          restaurantId: restaurantId,
          restaurantName: restaurantName,
          menuId: menuId,
          menuName: menuName,
          price: price,
          quantity: quantity,
        );

    setState(() {
      isClicked = false;
    });
  }
}
