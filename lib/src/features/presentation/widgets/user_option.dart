import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';

class UserOption extends StatelessWidget {
  const UserOption({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.secondaryColor,
        ),
        child: TabBar(
          indicator: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          unselectedLabelColor: AppColor.textColor,
          onTap: (index) {
            context.read<UserOptionCubit>().optionSelected(index);
          },
          tabs: const [
            Tab(
              icon: Text(
                "User",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Tab(
              icon: Text(
                "Admin",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
