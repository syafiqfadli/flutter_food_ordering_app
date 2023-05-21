import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return BaseAdminApp(
      title: "RESTAURANT",
      isMainPage: true,
      child: Expanded(
        child: CustomRefresh(
          onRefresh: _onRefresh,
          child: BlocBuilder<AdminInfoCubit, AdminEntity>(
            builder: (context, admin) {
              if (admin.restaurant.isEmpty) {
                return ListView(
                  children: const [
                    Center(
                      child: Text("You have no restaurant. Add one!"),
                    ),
                  ],
                );
              }
              return ListView.builder(
                itemCount: admin.restaurant.length,
                itemBuilder: (context, index) => RestaurantCard(
                  restaurant: admin.restaurant[index],
                  index: index,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await context.read<AdminInfoCubit>().adminInfo();
  }
}
