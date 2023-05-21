import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';

class CartDetailsCard extends StatefulWidget {
  final int cartIndex;
  final int menuIndex;
  final CartEntity cart;
  final MenuEntity menu;

  const CartDetailsCard({
    super.key,
    required this.cartIndex,
    required this.menuIndex,
    required this.cart,
    required this.menu,
  });

  @override
  State<CartDetailsCard> createState() => _CartDetailsCardState();
}

class _CartDetailsCardState extends State<CartDetailsCard> {
  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      '${widget.menuIndex + 1}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: SizedBox(
                        width: 140,
                        child: Text(
                          widget.menu.menuName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'Total: RM ${widget.menu.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  'x${widget.menu.quantity}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _deleteMenu(
                      cartIndex: widget.cartIndex,
                      cartId: widget.cart.cartId,
                      menuId: widget.menu.menuId,
                    );
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

  Future<void> _deleteMenu({
    required int cartIndex,
    required String cartId,
    required String menuId,
  }) async {
    await context.read<DeleteMenuCubit>().deleteMenu(
          cartId: cartId,
          menuId: menuId,
        );
  }
}
