import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/pages/pages.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseApp(
      title: "PROFILE",
      isMainPage: true,
      child: Expanded(
        child: CustomRefresh(
          onRefresh: _onRefresh,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: BlocBuilder<UserInfoCubit, UserEntity>(
                  builder: (context, user) {
                    return SizedBox(
                      width: width,
                      child: ListView(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor: AppColor.secondaryColor,
                              child: Icon(
                                Icons.account_circle,
                                size: 50,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              user.name,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(user.email),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              color: AppColor.secondaryColor,
                              width: width,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      "No. of Order",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      user.order.length.toString(),
                                      style: const TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: ElevatedButton(
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
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
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

  Future<void> _onRefresh() async {
    await context.read<UserInfoCubit>().userInfo();
  }
}
