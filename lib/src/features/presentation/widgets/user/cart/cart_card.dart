import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';
import 'package:order_me/src/core/utils/utils.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';
import 'package:order_me/src/features/presentation/pages/pages.dart';

class CartCard extends StatefulWidget {
  final int cartIndex;
  final CartEntity cart;

  const CartCard({super.key, required this.cart, required this.cartIndex});

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: InkWell(
        onTap: _navigateToCartDetails,
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.cart.restaurantName,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "(${widget.cart.menuList.length} menu)",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isClicked
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      )
                    : IconButton(
                        onPressed: _deleteCart,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 35,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _deleteCart() async {
    final cartId = widget.cart.cartId;

    setState(() {
      isClicked = true;
    });

    await context.read<DeleteCartCubit>().deleteCart(cartId: cartId);

    setState(() {
      isClicked = false;
    });
  }

  Future<void> _navigateToCartDetails() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CartDetailsPage(
          cartIndex: widget.cartIndex,
          cart: widget.cart,
        ),
      ),
    );

    if (result == null) {
      return;
    }

    if (result) {
      _deleteCart();
    }
  }
}
