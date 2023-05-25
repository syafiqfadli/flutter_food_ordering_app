import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class HomeDetailsPage extends StatefulWidget {
  final RestaurantEntity restaurant;
  final MenuEntity menu;

  const HomeDetailsPage({
    super.key,
    required this.restaurant,
    required this.menu,
  });

  @override
  State<HomeDetailsPage> createState() => _HomeDetailsPageState();
}

class _HomeDetailsPageState extends State<HomeDetailsPage> {
  final TextEditingController _quantityController =
      TextEditingController(text: "0");

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseUserApp(
      title: widget.restaurant.restaurantName.toUpperCase(),
      isMainPage: false,
      child: BlocListener<AddToCartCubit, AddToCartState>(
          listener: (context, state) async {
            if (state is AddToCartError) {
              DialogService.showMessage(
                title: "Error",
                message: state.message,
                icon: Icons.error,
                width: width,
                context: context,
              );
            }

            if (state is AddToCartSuccessful) {
              DialogService.showMessage(
                title: "Added to Cart",
                icon: Icons.check,
                width: width,
                context: context,
              );

              context.read<UserInfoCubit>().userInfo();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  widget.menu.menuName,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                height: 30,
                color: AppColor.primaryColor,
                thickness: 2,
                indent: 15,
                endIndent: 15,
              ),
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description:",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.menu.description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Text(
                  "Price: RM ${widget.menu.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              InputQuantity(quantityController: _quantityController),
              BlocSelector<AddToCartCubit, AddToCartState, bool>(
                selector: (state) {
                  if (state is AddToCartLoading) {
                    return true;
                  }

                  return false;
                },
                builder: (context, isLoading) {
                  if (isLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        fixedSize: Size(width, 50),
                      ),
                      onPressed: () {
                        _addToCart(
                          width: width,
                          restaurantId: widget.restaurant.restaurantId,
                          restaurantName: widget.restaurant.restaurantName,
                          menuId: widget.menu.menuId,
                          menuName: widget.menu.menuName,
                          price: widget.menu.price,
                          quantity: int.parse(_quantityController.text),
                        );
                      },
                      child: const Text('ADD TO CART'),
                    ),
                  );
                },
              ),
            ],
          )),
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

    _quantityController.text = "0";
  }
}
