import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class OrderUserDetailsPage extends StatefulWidget {
  final int index;
  final String restaurantName;

  const OrderUserDetailsPage({
    super.key,
    required this.index,
    required this.restaurantName,
  });

  @override
  State<OrderUserDetailsPage> createState() => _OrderUserDetailsPageState();
}

class _OrderUserDetailsPageState extends State<OrderUserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BaseUserApp(
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
                      itemBuilder: (context, index) => OrderUserDetailsCard(
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
