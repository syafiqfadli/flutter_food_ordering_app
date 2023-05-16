import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/widgets/order_details_card.dart';
import 'package:flutter_food_ordering_app/src/widgets/widgets.dart';

class OrderDetailsPage extends StatefulWidget {
  final int index;
  final String restaurantName;

  const OrderDetailsPage({
    super.key,
    required this.index,
    required this.restaurantName,
  });

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BaseApp(
      title: widget.restaurantName.toUpperCase(),
      isMainPage: false,
      child: Expanded(
        child: CustomRefresh(
          onRefresh: _onRefresh,
          child: BlocBuilder<UserInfoCubit, UserEntity>(
            builder: (context, user) {
              if (user.order.isEmpty) {
                return const SizedBox.shrink();
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: user.order[widget.index].orderList.length,
                      itemBuilder: (context, index) => OrderDetailsCard(
                        index: index,
                        menu: user.order[widget.index].orderList[index],
                      ),
                    ),
                  ),
                ],
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
}
