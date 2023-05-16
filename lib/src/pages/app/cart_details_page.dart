import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/pages/pages.dart';
import 'package:flutter_food_ordering_app/src/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/widgets/widgets.dart';

class CartDetailPage extends StatefulWidget {
  final int index;
  final String restaurantName;

  const CartDetailPage({
    super.key,
    required this.index,
    required this.restaurantName,
  });

  @override
  State<CartDetailPage> createState() => _CartDetailPageState();
}

class _CartDetailPageState extends State<CartDetailPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseApp(
      title: widget.restaurantName.toUpperCase(),
      isMainPage: false,
      child: BlocListener<CheckoutOrderCubit, CheckoutOrderState>(
        listener: (context, state) async {
          if (state is CheckoutOrderError) {
            await DialogService.showMessage(
              title: "Error",
              message: state.message,
              icon: Icons.error,
              width: width,
              context: context,
            );
          }

          if (!mounted) return;

          if (state is CheckoutOrderSuccessful) {
            await DialogService.showMessage(
              title: "Checked Out",
              icon: Icons.check,
              width: width,
              context: context,
            );

            if (!mounted) return;

            context.read<SetPageCubit>().setIndex(3);

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const AppPage(),
              ),
              (route) => false,
            );
          }
        },
        child: Expanded(
          child: CustomRefresh(
            onRefresh: _onRefresh,
            child: BlocBuilder<UserInfoCubit, UserEntity>(
              builder: (context, user) {
                if (user.cart.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: user.cart[widget.index].menuList.length,
                        itemBuilder: (context, index) => CartDetailsCard(
                          index: index,
                          menu: user.cart[widget.index].menuList[index],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _checkout(user.cart[widget.index].cartId);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          fixedSize: Size(width, 50),
                        ),
                        child: const Text('CHECKOUT'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await context.read<UserInfoCubit>().userInfo();
  }

  Future<void> _checkout(String cartId) async {
    await context.read<CheckoutOrderCubit>().checkoutOrder(cartId: cartId);
  }
}
