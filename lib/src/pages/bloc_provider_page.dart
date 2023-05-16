import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/injections/injections.dart';

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
  final SetPageCubit _setPageCubit = blocInject<SetPageCubit>();
  final ServerCubit _serverCubit = blocInject<ServerCubit>();
  final UserInfoCubit _userInfoCubit = blocInject<UserInfoCubit>();
  final CheckoutOrderCubit _checkoutOrderCubit =
      blocInject<CheckoutOrderCubit>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _signUpCubit),
        BlocProvider(create: (context) => _loginCubit),
        BlocProvider.value(value: _logoutCubit),
        BlocProvider.value(value: _setPageCubit),
        BlocProvider.value(value: _serverCubit),
        BlocProvider.value(value: _userInfoCubit),
        BlocProvider.value(value: _checkoutOrderCubit),
      ],
      child: widget.child,
    );
  }
}
