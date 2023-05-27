import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/injections/injections.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class OrderUserDetailsPage extends StatefulWidget {
  final int index;
  final OrderEntity order;

  const OrderUserDetailsPage({
    super.key,
    required this.index,
    required this.order,
  });

  @override
  State<OrderUserDetailsPage> createState() => _OrderUserDetailsPageState();
}

class _OrderUserDetailsPageState extends State<OrderUserDetailsPage> {
  late UserInfoCubit userInfoCubit;

  @override
  void dispose() {
    super.dispose();
    userInfoCubit = blocInject<UserInfoCubit>()..userInfo();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseUserApp(
      title: widget.order.restaurantName.toUpperCase(),
      isMainPage: false,
      child: MultiBlocListener(
        listeners: [
          BlocListener<CompleteOrderCubit, CompleteOrderState>(
            listener: (context, state) async {
              if (state is CompleteOrderError) {
                DialogService.showMessage(
                  title: "Error",
                  message: state.message,
                  icon: Icons.error,
                  width: width,
                  context: context,
                );
              }

              if (state is CompleteOrderSuccessful) {
                await DialogService.showMessage(
                  title: "Order completed",
                  icon: Icons.check,
                  width: width,
                  context: context,
                );

                if (!mounted) return;

                Navigator.pop(context);
              }
            },
          ),
          BlocListener<CancelOrderCubit, CancelOrderState>(
            listener: (context, state) async {
              if (state is CancelOrderError) {
                DialogService.showMessage(
                  title: "Error",
                  message: state.message,
                  icon: Icons.error,
                  width: width,
                  context: context,
                );
              }

              if (state is CancelOrderSuccessful) {
                await DialogService.showMessage(
                  title: "Order cancelled",
                  icon: Icons.check,
                  width: width,
                  context: context,
                );

                if (!mounted) return;

                Navigator.pop(context);
              }
            },
          ),
        ],
        child: Expanded(
          child: CustomRefresh(
            onRefresh: _onRefresh,
            child: BlocBuilder<UserInfoCubit, UserEntity>(
              builder: (context, user) {
                final order = user.order[widget.index];

                if (order.orderList.isEmpty) {
                  return const SizedBox.shrink();
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: order.orderList.length,
                        itemBuilder: (context, index) => OrderUserDetailsCard(
                          index: index,
                          menu: order.orderList[index],
                        ),
                      ),
                    ),
                    order.status == "In the kitchen"
                        ? Padding(
                            padding: const EdgeInsets.all(8),
                            child: BlocSelector<CancelOrderCubit,
                                CancelOrderState, bool>(
                              selector: (state) {
                                if (state is CancelOrderLoading) {
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
                                  onPressed: () {
                                    _onCancel(orderId: order.orderId);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[400],
                                    fixedSize: Size(width, 50),
                                  ),
                                  child: const Text('CANCEL'),
                                );
                              },
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8),
                            child: BlocSelector<CompleteOrderCubit,
                                CompleteOrderState, bool>(
                              selector: (state) {
                                if (state is CompleteOrderLoading) {
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
                                  onPressed: () {
                                    _onArrived(orderId: order.orderId);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primaryColor,
                                    fixedSize: Size(width, 50),
                                  ),
                                  child: const Text('ARRIVED'),
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
    await context.read<UserInfoCubit>().userInfo();
  }

  Future<void> _onArrived({required String orderId}) async {
    await context.read<CompleteOrderCubit>().completeOrder(orderId: orderId);
  }

  Future<void> _onCancel({required String orderId}) async {
    await context.read<CancelOrderCubit>().cancelOrder(orderId: orderId);
  }
}
