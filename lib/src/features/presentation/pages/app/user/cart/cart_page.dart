import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/injections/injections.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late UserInfoCubit userInfoCubit;

  @override
  void initState() {
    super.initState();
    userInfoCubit = blocInject<UserInfoCubit>()..userInfo();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseUserApp(
      title: "CART",
      isMainPage: false,
      child: BlocListener<DeleteCartCubit, DeleteCartState>(
        listener: (context, state) async {
          if (state is DeleteCartError) {
            await DialogService.showMessage(
              title: "Error",
              message: state.message,
              icon: Icons.error,
              width: width,
              context: context,
            );
          }

          if (!mounted) return;

          if (state is DeleteCartSuccessful) {
            DialogService.showMessage(
              title: "Cart removed.",
              icon: Icons.check,
              width: width,
              context: context,
            );
          }
        },
        child: Expanded(
          child: CustomRefresh(
            onRefresh: _onRefresh,
            child: BlocBuilder<UserInfoCubit, UserEntity>(
              builder: (context, user) {
                if (user.cart.isEmpty) {
                  return ListView(
                    children: const [
                      Center(
                        child: Text("Your cart is empty. Add one!"),
                      ),
                    ],
                  );
                }

                return ListView.builder(
                  itemCount: user.cart.length,
                  itemBuilder: (context, index) => CartCard(
                    cartIndex: index,
                    cart: user.cart[index],
                  ),
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
}
