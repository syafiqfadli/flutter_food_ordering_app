import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class OrderAdminDetailsPage extends StatefulWidget {
  final int index;
  final String restaurantName;

  const OrderAdminDetailsPage({
    super.key,
    required this.index,
    required this.restaurantName,
  });

  @override
  State<OrderAdminDetailsPage> createState() => _OrderAdminDetailsPageState();
}

class _OrderAdminDetailsPageState extends State<OrderAdminDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return BaseUserApp(
      title: widget.restaurantName.toUpperCase(),
      isMainPage: false,
      child: Expanded(
        child: CustomRefresh(
          onRefresh: _onRefresh,
          child: BlocBuilder<AdminInfoCubit, AdminEntity>(
            builder: (context, admin) {
              if (admin.order.isEmpty) {
                return const SizedBox.shrink();
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: admin.order[widget.index].orderList.length,
                      itemBuilder: (context, index) => OrderAdminDetailsCard(
                        index: index,
                        menu: admin.order[widget.index].orderList[index],
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
