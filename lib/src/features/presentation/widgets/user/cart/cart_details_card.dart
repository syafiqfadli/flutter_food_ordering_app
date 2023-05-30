import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';
import 'package:order_me/src/core/utils/utils.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';

class CartDetailsCard extends StatefulWidget {
  final int menuIndex;
  final CartEntity cart;
  final MenuEntity menu;
  final List<MenuEntity> menuList;

  const CartDetailsCard({
    super.key,
    required this.menuIndex,
    required this.cart,
    required this.menu,
    required this.menuList,
  });

  @override
  State<CartDetailsCard> createState() => _CartDetailsCardState();
}

class _CartDetailsCardState extends State<CartDetailsCard> {
  bool isClicked = false;

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
                        child: AutoSizeText(
                          widget.menu.menuName,
                          maxLines: 2,
                          minFontSize: 20,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
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
                isClicked
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      )
                    : IconButton(
                        onPressed: _deleteMenu,
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

  Future<void> _deleteMenu() async {
    final cartId = widget.cart.cartId;
    final menuId = widget.menu.menuId;

    setState(() {
      isClicked = true;
    });

    if (widget.menuList.length == 1) {
      Navigator.pop(context, true);

      setState(() {
        isClicked = false;
      });

      return;
    }

    await context.read<DeleteMenuUserCubit>().deleteMenu(
          cartId: cartId,
          menuId: menuId,
        );

    setState(() {
      isClicked = false;
    });
  }
}
