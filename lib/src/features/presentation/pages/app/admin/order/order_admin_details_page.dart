import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class OrderAdminDetailsPage extends StatefulWidget {
  final int index;
  final OrderEntity order;

  const OrderAdminDetailsPage({
    super.key,
    required this.index,
    required this.order,
  });

  @override
  State<OrderAdminDetailsPage> createState() => _OrderAdminDetailsPageState();
}

class _OrderAdminDetailsPageState extends State<OrderAdminDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseAdminApp(
      title: widget.order.restaurantName.toUpperCase(),
      isMainPage: false,
      child: BlocListener<UpdateStatusCubit, UpdateStatusState>(
        listener: (context, state) {
          if (state is UpdateStatusError) {
            DialogService.showMessage(
              title: "Error",
              message: state.message,
              icon: Icons.error,
              width: width,
              context: context,
            );
          }

          if (state is UpdateStatusSuccessful) {
            DialogService.showMessage(
              title: "Status updated",
              icon: Icons.check,
              width: width,
              context: context,
            );
          }
        },
        child: Expanded(
          child: CustomRefresh(
            onRefresh: _onRefresh,
            child: BlocBuilder<AdminInfoCubit, AdminEntity>(
              builder: (context, admin) {
                final order = admin.order[widget.index];

                if (order.orderList.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 8,
                      ),
                      child: Text(
                        "Customer: ${order.customerName.toTitleCase()}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: order.orderList.length,
                        itemBuilder: (context, index) => OrderAdminDetailsCard(
                          index: index,
                          menu: order.orderList[index],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: BlocSelector<UpdateStatusCubit, UpdateStatusState,
                          bool>(
                        selector: (state) {
                          if (state is UpdateStatusLoading) {
                            return true;
                          }

                          return false;
                        },
                        builder: (context, isLoading) {
                          if (isLoading) {
                            return const Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.primaryColor,
                                ),
                              ),
                            );
                          }

                          return ElevatedButton(
                            onPressed: order.status == "In the kitchen"
                                ? () {
                                    _onUpdate(order.orderId);
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              fixedSize: Size(width, 50),
                            ),
                            child: order.status == "In the kitchen"
                                ? const Text('PROCEED FOR DELIVERY')
                                : order.status == "Out of delivery"
                                    ? const Text('OUT OF DELIVERY')
                                    : const Text('COMPLETED'),
                          );
                        },
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
    await context.read<AdminInfoCubit>().adminInfo();
  }

  Future<void> _onUpdate(String orderId) async {
    await context.read<UpdateStatusCubit>().updateStatus(orderId: orderId);
    _onRefresh();
  }
}
