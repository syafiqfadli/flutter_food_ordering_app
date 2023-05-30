import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/core/utils/utils.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';
import 'package:order_me/src/features/presentation/widgets/admin/restaurant/menu_card.dart';
import 'package:order_me/src/features/presentation/widgets/widgets.dart';

class RestaurantDetailsPage extends StatefulWidget {
  final int index;
  final RestaurantEntity restaurant;

  const RestaurantDetailsPage({
    super.key,
    required this.index,
    required this.restaurant,
  });

  @override
  State<RestaurantDetailsPage> createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseAdminApp(
      title: "MENU",
      isMainPage: false,
      restaurant: widget.restaurant,
      child: BlocListener<DeleteMenuAdminCubit, DeleteMenuAdminState>(
        listener: (context, state) {
          if (state is DeleteMenuAdminError) {
            DialogService.showMessage(
              title: "Delete Menu Error",
              message: state.message,
              icon: Icons.error,
              width: width,
              context: context,
            );
          }

          if (state is DeleteMenuAdminSuccessful) {
            _onRefresh();
          }
        },
        child: Expanded(
          child: CustomRefresh(
            onRefresh: _onRefresh,
            child: BlocBuilder<AdminInfoCubit, AdminEntity>(
              builder: (context, admin) {
                if (admin.restaurant[widget.index].menuList.isEmpty) {
                  return ListView(
                    children: const [
                      Center(
                        child: Text("No menu yet. Add one!"),
                      ),
                    ],
                  );
                }

                return ListView.builder(
                  itemCount: admin.restaurant[widget.index].menuList.length,
                  itemBuilder: (context, index) => MenuCard(
                    index: index,
                    restaurant: widget.restaurant,
                    menu: admin.restaurant[widget.index].menuList[index],
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
