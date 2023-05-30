import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/core/injections/injections.dart';
import 'package:order_me/src/core/utils/utils.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';
import 'package:order_me/src/features/presentation/pages/pages.dart';
import 'package:order_me/src/features/presentation/widgets/widgets.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  late InKitchenCubit inKitchenCubit;
  late DeliveryCubit deliveryCubit;
  late CompletedCubit completedCubit;
  late CancelledCubit cancelledCubit;

  @override
  void initState() {
    super.initState();
    inKitchenCubit = blocInject<InKitchenCubit>()..inKitchen();
    deliveryCubit = blocInject<DeliveryCubit>()..outOfDelivery();
    completedCubit = blocInject<CompletedCubit>()..completed();
    cancelledCubit = blocInject<CancelledCubit>()..cancelled();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseAdminApp(
      title: "PROFILE",
      isMainPage: true,
      child: Expanded(
        child: CustomRefresh(
          onRefresh: _onRefresh,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: BlocBuilder<AdminInfoCubit, AdminEntity>(
                  builder: (context, admin) {
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
                            admin.name.toTitleCase(),
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(admin.email),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            color: AppColor.secondaryColor,
                            width: width,
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    BlocBuilder<InKitchenCubit, int>(
                                      builder: (context, length) {
                                        return ProfileOrderStatus(
                                          orderLength: length,
                                          status: "In Kitchen",
                                          boxColor: Colors.blue[200]!,
                                        );
                                      },
                                    ),
                                    BlocBuilder<DeliveryCubit, int>(
                                      builder: (context, length) {
                                        return ProfileOrderStatus(
                                          orderLength: length,
                                          status: "Out of Delivery",
                                          boxColor: Colors.yellow[200]!,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    BlocBuilder<CompletedCubit, int>(
                                      builder: (context, length) {
                                        return ProfileOrderStatus(
                                          orderLength: length,
                                          status: "Completed",
                                          boxColor: Colors.green[400]!,
                                        );
                                      },
                                    ),
                                    BlocBuilder<CancelledCubit, int>(
                                      builder: (context, length) {
                                        return ProfileOrderStatus(
                                          orderLength: length,
                                          status: "Cancelled",
                                          boxColor: Colors.red[200]!,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
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

  void _logout() async {
    await context.read<LogoutCubit>().logout();

    if (!mounted) return;

    context.read<SetPageAdminCubit>().setIndex(0);
    context.read<UserOptionCubit>().resetOption();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const WelcomePage(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  Future<void> _onRefresh() async {
    context.read<InKitchenCubit>().inKitchen();
    context.read<DeliveryCubit>().outOfDelivery();
    context.read<CompletedCubit>().completed();
    context.read<CancelledCubit>().cancelled();

    await context.read<AdminInfoCubit>().adminInfo();
  }
}
