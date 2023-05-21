import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/injections/injections.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/pages/pages.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class CartDetailsPage extends StatefulWidget {
  final int cartIndex;
  final CartEntity cart;

  const CartDetailsPage({
    super.key,
    required this.cartIndex,
    required this.cart,
  });

  @override
  State<CartDetailsPage> createState() => _CartDetailsPageState();
}

class _CartDetailsPageState extends State<CartDetailsPage> {
  final UserInfoCubit userInfoCubit = blocInject<UserInfoCubit>();
  final DeleteCartCubit deleteCartCubit = blocInject<DeleteCartCubit>();

  @override
  void dispose() {
    super.dispose();
    if (userInfoCubit.state.cart[widget.cartIndex].menuList.isEmpty) {
      deleteCartCubit.deleteCart(cartId: widget.cart.cartId);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        (kToolbarHeight + 52) -
        MediaQuery.of(context).padding.top;

    return BaseUserApp(
      title: widget.cart.restaurantName.toUpperCase(),
      isMainPage: false,
      child: MultiBlocListener(
        listeners: [
          BlocListener<DeleteMenuCubit, DeleteMenuState>(
            listener: (context, state) async {
              if (state is DeleteMenuError) {
                DialogService.showMessage(
                  title: "Error",
                  message: state.message,
                  icon: Icons.error,
                  width: width,
                  context: context,
                );
              }
            },
          ),
          BlocListener<UserInfoCubit, UserEntity>(
            listener: (context, user) async {
              if (user.cart[widget.cartIndex].menuList.isEmpty) {
                Navigator.pop(context);
              }
            },
          ),
          BlocListener<CheckoutOrderCubit, CheckoutOrderState>(
            listener: (context, state) async {
              if (state is CheckoutOrderError) {
                DialogService.showMessage(
                  title: "Error",
                  message: state.message,
                  icon: Icons.error,
                  width: width,
                  context: context,
                );
              }

              if (state is CheckoutOrderSuccessful) {
                await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const PaymentStatusPage(),
                  ),
                );

                if (!mounted) return;

                context.read<UserInfoCubit>().userInfo();
              }
            },
          ),
        ],
        child: CustomRefresh(
          onRefresh: _onRefresh,
          child: BlocBuilder<UserInfoCubit, UserEntity>(
            builder: (context, user) {
              if (user.cart[widget.cartIndex].menuList.isEmpty) {
                return const SizedBox.shrink();
              }

              return SizedBox(
                height: height,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: user.cart[widget.cartIndex].menuList.length,
                        itemBuilder: (context, index) => CartDetailsCard(
                          cartIndex: widget.cartIndex,
                          menuIndex: index,
                          cart: user.cart[widget.cartIndex],
                          menu: user.cart[widget.cartIndex].menuList[index],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Divider(color: AppColor.primaryColor),
                      ),
                      SummaryDetails(
                        menuList: user.cart[widget.cartIndex].menuList,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Divider(color: AppColor.primaryColor),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BlocSelector<CheckoutOrderCubit,
                            CheckoutOrderState, bool>(
                          selector: (state) {
                            if (state is CheckoutOrderLoading) {
                              return true;
                            }
                            return false;
                          },
                          builder: (context, isLoading) {
                            if (isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.primaryColor,
                                ),
                              );
                            }

                            return ElevatedButton(
                              onPressed: () {
                                _checkout(
                                  widget.cart.cartId,
                                  widget.cart.restaurantId,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                                fixedSize: Size(width, 50),
                              ),
                              child: const Text('CHECKOUT'),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _checkout(String cartId, String restaurantId) async {
    await context.read<CheckoutOrderCubit>().checkoutOrder(
          cartId: cartId,
          restaurantId: restaurantId,
        );
  }

  Future<void> _onRefresh() async {
    await context.read<UserInfoCubit>().userInfo();
  }
}
