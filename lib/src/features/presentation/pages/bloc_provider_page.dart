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
  final SignUpCubit _signUpCubit = blocInject<SignUpCubit>();
  final LoginCubit _loginCubit = blocInject<LoginCubit>();
  final LogoutCubit _logoutCubit = blocInject<LogoutCubit>();
  final SetPageUserCubit _setPageCubit = blocInject<SetPageUserCubit>();
  final ServerCubit _serverCubit = blocInject<ServerCubit>();
  final UserInfoCubit _userInfoCubit = blocInject<UserInfoCubit>();
  final HomeCubit _homeCubit = blocInject<HomeCubit>();
  final DeleteCartCubit _deleteCartCubit = blocInject<DeleteCartCubit>();
  final DeleteMenuCubit _deleteMenuCubit = blocInject<DeleteMenuCubit>();
  final AddToCartCubit _addToCartCubit = blocInject<AddToCartCubit>();
  final UserOptionCubit _userOptionCubit = blocInject<UserOptionCubit>();
  final CheckoutOrderCubit _checkoutOrderCubit =
      blocInject<CheckoutOrderCubit>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _signUpCubit),
        BlocProvider.value(value: _loginCubit),
        BlocProvider.value(value: _logoutCubit),
        BlocProvider.value(value: _setPageCubit),
        BlocProvider.value(value: _serverCubit),
        BlocProvider.value(value: _homeCubit),
        BlocProvider.value(value: _userInfoCubit),
        BlocProvider.value(value: _checkoutOrderCubit),
        BlocProvider.value(value: _addToCartCubit),
        BlocProvider.value(value: _deleteCartCubit),
        BlocProvider.value(value: _deleteMenuCubit),
        BlocProvider.value(value: _userOptionCubit),
      ],
      child: widget.child,
    );
  }
}
