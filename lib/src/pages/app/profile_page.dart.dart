import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/pages/pages.dart';
import 'package:flutter_food_ordering_app/src/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BaseApp(
      title: "PROFILE",
      isMainPage: true,
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _logout,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.backgroundColor,
              side: const BorderSide(
                color: AppColor.primaryColor,
                width: 0.7,
              ),
              fixedSize: const Size(190, 40),
            ),
            child: const Text(
              "LOG OUT",
              style: TextStyle(color: AppColor.primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  void _logout() async {
    await context.read<LogoutCubit>().logout();

    if (!mounted) return;

    context.read<SetPageCubit>().setIndex(0);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const WelcomePage(),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
