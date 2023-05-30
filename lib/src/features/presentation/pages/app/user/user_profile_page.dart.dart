import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';
import 'package:order_me/src/core/utils/utils.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';
import 'package:order_me/src/features/presentation/pages/pages.dart';
import 'package:order_me/src/features/presentation/widgets/widgets.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseUserApp(
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
                    return ListView(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: CircleAvatar(
                            foregroundColor: AppColor.primaryColor,
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
                            user.name.toTitleCase(),
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(user.email),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            color: AppColor.secondaryColor,
                            width: width,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
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
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
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

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const WelcomePage(),
      ),
      (Route<dynamic> route) => false,
    );

    context.read<LogoutCubit>().logout();
    context.read<SetPageUserCubit>().setIndex(0);
    context.read<UserOptionCubit>().resetOption();
  }

  Future<void> _onRefresh() async {
    await context.read<UserInfoCubit>().userInfo();
  }
}
