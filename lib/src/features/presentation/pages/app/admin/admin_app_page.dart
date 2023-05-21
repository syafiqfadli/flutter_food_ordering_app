import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';

class AdminAppPage extends StatefulWidget {
  const AdminAppPage({Key? key}) : super(key: key);

  @override
  State<AdminAppPage> createState() => _AdminAppPageState();
}

class _AdminAppPageState extends State<AdminAppPage> {
  final pages = [
    const Text("ADMIN PAGE"),
    Container(),
    Container(),
    Container(),
  ];

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
                label: "Restaurant",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history),
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
