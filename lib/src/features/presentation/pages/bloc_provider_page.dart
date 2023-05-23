import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/injections/injections.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';

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
  final DeleteMenuCubit _deleteMenuCubit = blocInject<DeleteMenuCubit>();
  final AddToCartCubit _addToCartCubit = blocInject<AddToCartCubit>();
  final CompleteOrderCubit _completeOrderCubit =
      blocInject<CompleteOrderCubit>();
  final CheckoutOrderCubit _checkoutOrderCubit =
      blocInject<CheckoutOrderCubit>();
  final AdminInfoCubit _adminInfoCubit = blocInject<AdminInfoCubit>();
  final InKitchenCubit _inKitchenCubit = blocInject<InKitchenCubit>();
  final DeliveryCubit _deliveryCubit = blocInject<DeliveryCubit>();
  final CompletedCubit _completedCubit = blocInject<CompletedCubit>();
  final UpdateStatusCubit _updateStatusCubit = blocInject<UpdateStatusCubit>();
  final AddMenuCubit _addMenuCubit = blocInject<AddMenuCubit>();
  final AddRestaurantCubit _addRestaurantCubit =
      blocInject<AddRestaurantCubit>();

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
        BlocProvider.value(value: _deleteMenuCubit),
        BlocProvider.value(value: _addToCartCubit),
        BlocProvider.value(value: _completeOrderCubit),
        BlocProvider.value(value: _checkoutOrderCubit),
        BlocProvider.value(value: _adminInfoCubit),
        BlocProvider.value(value: _inKitchenCubit),
        BlocProvider.value(value: _deliveryCubit),
        BlocProvider.value(value: _completedCubit),
        BlocProvider.value(value: _updateStatusCubit),
        BlocProvider.value(value: _addMenuCubit),
        BlocProvider.value(value: _addRestaurantCubit),
      ],
      child: widget.child,
    );
  }
}
