import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/injections/injections.dart';
import 'package:flutter_food_ordering_app/src/pages/pages.dart';
import 'package:flutter_food_ordering_app/src/utils/utils.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  final SetPageCubit setPageCubit = blocInject<SetPageCubit>();
  final pages = [
    const HomePage(),
    const StatusPage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SetPageCubit, int>(
      builder: (context, pageNum) {
        return Scaffold(
          body: pages[pageNum],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            selectedFontSize: 12,
            elevation: 20,
            unselectedItemColor: Colors.grey[400],
            selectedItemColor: AppColor.primaryColor,
            currentIndex: pageNum,
            onTap: (index) {
              setPageCubit.setIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time),
                label: "Status",
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
        );
      },
    );
  }
}
