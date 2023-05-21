import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Icon(
          Icons.shopping_cart,
          size: 30,
          color: AppColor.backgroundColor,
        ),
        Positioned(
          right: 0,
          child: BlocBuilder<UserInfoCubit, UserEntity>(
            builder: (context, user) {
              if (user.cart.isNotEmpty) {
                return Container(
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Center(
                    child: Text(
                      user.cart.length.toString(),
                      style: const TextStyle(
                        color: AppColor.backgroundColor,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        )
      ],
    );
  }
}
