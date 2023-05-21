import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/injections/injections.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/pages/pages.dart';

class UserAppPage extends StatefulWidget {
  const UserAppPage({Key? key}) : super(key: key);

  @override
  State<UserAppPage> createState() => _UserAppPageState();
}

class _UserAppPageState extends State<UserAppPage> {
  late UserInfoCubit userInfoCubit;
  late HomeCubit homeCubit;

  final pages = [
    const HomePage(),
    const OrderUserPage(),
    const HistoryPage(),
    const UserProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    userInfoCubit = blocInject<UserInfoCubit>()..userInfo();
    homeCubit = blocInject<HomeCubit>()..homeDefault();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetPageUserCubit, int>(
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
              context.read<SetPageUserCubit>().setIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time),
                label: "Order",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: "History",
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
