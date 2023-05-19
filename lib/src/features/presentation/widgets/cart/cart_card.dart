import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/pages/pages.dart';

class CartCard extends StatefulWidget {
  final int cartIndex;
  final CartEntity cart;

  const CartCard({super.key, required this.cartIndex, required this.cart});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CartDetailsPage(
                cartIndex: widget.cartIndex,
                cart: widget.cart,
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
                      horizontal: 15,
                      vertical: 30,
                    ),
                    child: Text(
                      widget.cart.restaurantName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _deleteCart(cartId: widget.cart.cartId);
                  },
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

  Future<void> _deleteCart({required String cartId}) async {
    await context.read<DeleteCartCubit>().deleteCart(cartId: cartId);
  }
}
