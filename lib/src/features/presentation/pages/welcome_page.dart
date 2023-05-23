import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/auth/auth.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/pages/pages.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: Image.asset(
                "assets/images/order-me-logo.png",
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                onPressed: () {
                  _pageNavigator(context, page: const SignUpPage());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.secondaryColor,
                  fixedSize: const Size(200, 50),
                ),
                child: const Text(
                  "SIGN UP",
                  style: TextStyle(
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _pageNavigator(context, page: const LoginPage());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
                side: const BorderSide(
                  color: AppColor.secondaryColor,
                  width: 0.7,
                ),
                fixedSize: const Size(200, 50),
              ),
              child: const Text("LOG IN"),
            ),
          ],
        ),
      ),
    );
  }
}

void _pageNavigator(BuildContext context, {required Widget page}) {
  context.read<UserOptionCubit>().optionSelected(0);
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page));
}
