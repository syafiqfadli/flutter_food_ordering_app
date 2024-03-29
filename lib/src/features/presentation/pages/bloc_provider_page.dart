import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/core/injections/injections.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';

class BlocProviderPage extends StatefulWidget {
  final Widget child;
  const BlocProviderPage({super.key, required this.child});

  @override
  State<BlocProviderPage> createState() => _BlocProviderPageState();
}

class _BlocProviderPageState extends State<BlocProviderPage> {
  final ServerCubit _serverCubit = blocInject<ServerCubit>();
  final SetPageUserCubit _setPageUserCubit = blocInject<SetPageUserCubit>();
  final SetPageAdminCubit _setPageAdminCubit = blocInject<SetPageAdminCubit>();
  final UserOptionCubit _userOptionCubit = blocInject<UserOptionCubit>();
  final SignUpCubit _signUpCubit = blocInject<SignUpCubit>();
  final LoginCubit _loginCubit = blocInject<LoginCubit>();
  final LogoutCubit _logoutCubit = blocInject<LogoutCubit>();
  final UserInfoCubit _userInfoCubit = blocInject<UserInfoCubit>();
  final HomeCubit _homeCubit = blocInject<HomeCubit>();
  final DeleteCartCubit _deleteCartCubit = blocInject<DeleteCartCubit>();
  final DeleteMenuUserCubit _deleteMenuUserCubit =
      blocInject<DeleteMenuUserCubit>();
  final AddToCartCubit _addToCartCubit = blocInject<AddToCartCubit>();
  final CompleteOrderCubit _completeOrderCubit =
      blocInject<CompleteOrderCubit>();
  final CancelOrderCubit _cancelOrderCubit = blocInject<CancelOrderCubit>();
  final CheckoutOrderCubit _checkoutOrderCubit =
      blocInject<CheckoutOrderCubit>();
  final AdminInfoCubit _adminInfoCubit = blocInject<AdminInfoCubit>();
  final InKitchenCubit _inKitchenCubit = blocInject<InKitchenCubit>();
  final DeliveryCubit _deliveryCubit = blocInject<DeliveryCubit>();
  final CompletedCubit _completedCubit = blocInject<CompletedCubit>();
  final CancelledCubit _cancelledCubit = blocInject<CancelledCubit>();
  final UpdateStatusCubit _updateStatusCubit = blocInject<UpdateStatusCubit>();
  final AddMenuCubit _addMenuCubit = blocInject<AddMenuCubit>();
  final EditMenuCubit _editMenuCubit = blocInject<EditMenuCubit>();
  final AddRestaurantCubit _addRestaurantCubit =
      blocInject<AddRestaurantCubit>();
  final DeleteMenuAdminCubit _deleteMenuAdminCubit =
      blocInject<DeleteMenuAdminCubit>();
  final DeleteRestaurantCubit _deleteRestaurantCubit =
      blocInject<DeleteRestaurantCubit>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _serverCubit),
        BlocProvider.value(value: _setPageUserCubit),
        BlocProvider.value(value: _setPageAdminCubit),
        BlocProvider.value(value: _userOptionCubit),
        BlocProvider.value(value: _signUpCubit),
        BlocProvider.value(value: _loginCubit),
        BlocProvider.value(value: _logoutCubit),
        BlocProvider.value(value: _userInfoCubit),
        BlocProvider.value(value: _homeCubit),
        BlocProvider.value(value: _deleteCartCubit),
        BlocProvider.value(value: _deleteMenuUserCubit),
        BlocProvider.value(value: _addToCartCubit),
        BlocProvider.value(value: _completeOrderCubit),
        BlocProvider.value(value: _cancelOrderCubit),
        BlocProvider.value(value: _checkoutOrderCubit),
        BlocProvider.value(value: _adminInfoCubit),
        BlocProvider.value(value: _inKitchenCubit),
        BlocProvider.value(value: _deliveryCubit),
        BlocProvider.value(value: _completedCubit),
        BlocProvider.value(value: _cancelledCubit),
        BlocProvider.value(value: _updateStatusCubit),
        BlocProvider.value(value: _addMenuCubit),
        BlocProvider.value(value: _editMenuCubit),
        BlocProvider.value(value: _addRestaurantCubit),
        BlocProvider.value(value: _deleteMenuAdminCubit),
        BlocProvider.value(value: _deleteRestaurantCubit),
      ],
      child: widget.child,
    );
  }
}
