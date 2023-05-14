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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _signUpCubit),
        BlocProvider.value(value: _loginCubit),
        BlocProvider.value(value: _logoutCubit),
        BlocProvider.value(value: _setPageCubit),
      ],
      child: widget.child,
    );
  }
}
