import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return BaseUserApp(
      title: "ORDER",
      isMainPage: true,
      child: Expanded(
        child: CustomRefresh(
          onRefresh: _onRefresh,
          child: BlocBuilder<UserInfoCubit, UserEntity>(
            builder: (context, user) {
              if (user.order.isEmpty) {
                return ListView(
                  children: const [
                    Center(
                      child: Text("Your order is empty. Check your cart!"),
                    ),
                  ],
                );
              }
              return ListView.builder(
                itemCount: user.order.length,
                itemBuilder: (context, index) => OrderCard(
                  order: _sortedOrder(user.order, index),
                  index: index,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await context.read<UserInfoCubit>().userInfo();
  }

  OrderEntity _sortedOrder(List<OrderEntity> orderList, int index) {
    return List<OrderEntity>.from(orderList.reversed)[index];
  }
}
