import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/core/utils/utils.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';
import 'package:order_me/src/features/presentation/widgets/widgets.dart';

class RestaurantPage extends StatefulWidget {
  const RestaurantPage({super.key});

  @override
  State<RestaurantPage> createState() => _RestaurantPageState();
}

class _RestaurantPageState extends State<RestaurantPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseAdminApp(
      title: "RESTAURANT",
      isMainPage: true,
      child: BlocListener<DeleteRestaurantCubit, DeleteRestaurantState>(
        listener: (context, state) {
          if (state is DeleteRestaurantError) {
            DialogService.showMessage(
              title: "Delete Restaurant Error",
              message: state.message,
              icon: Icons.error,
              width: width,
              context: context,
            );
          }

          if (state is DeleteRestaurantSuccessful) {
            _onRefresh();
          }
        },
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
      ),
    );
  }

  Future<void> _onRefresh() async {
    await context.read<AdminInfoCubit>().adminInfo();
  }
}
