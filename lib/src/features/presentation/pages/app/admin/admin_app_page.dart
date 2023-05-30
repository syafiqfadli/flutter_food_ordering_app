import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/core/injections/bloc_inject.dart';
import 'package:order_me/src/core/utils/utils.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';
import 'package:order_me/src/features/presentation/pages/pages.dart';

class AdminAppPage extends StatefulWidget {
  const AdminAppPage({Key? key}) : super(key: key);

  @override
  State<AdminAppPage> createState() => _AdminAppPageState();
}

class _AdminAppPageState extends State<AdminAppPage> {
  late AdminInfoCubit adminInfoCubit;
  late InKitchenCubit inKitchenCubit;
  late DeliveryCubit deliveryCubit;
  late CompletedCubit completedCubit;

  final pages = [
    const RestaurantPage(),
    const OrderAdminPage(),
    const AdminProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    adminInfoCubit = blocInject<AdminInfoCubit>()..adminInfo();
    inKitchenCubit = blocInject<InKitchenCubit>()..inKitchen();
    deliveryCubit = blocInject<DeliveryCubit>()..outOfDelivery();
    completedCubit = blocInject<CompletedCubit>()..completed();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetPageAdminCubit, int>(
      builder: (context, pageNum) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            selectedFontSize: 12,
            elevation: 20,
            unselectedItemColor: Colors.grey[400],
            selectedItemColor: AppColor.primaryColor,
            currentIndex: pageNum,
            onTap: (index) {
              context.read<SetPageAdminCubit>().setIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                label: "Restaurant",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time),
                label: "Order",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: "Profile",
              ),
            ],
          ),
          body: pages[pageNum],
        );
      },
    );
  }
}
