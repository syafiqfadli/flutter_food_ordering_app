import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class HomeDetailsPage extends StatefulWidget {
  final int index;
  final RestaurantEntity restaurant;

  const HomeDetailsPage({
    super.key,
    required this.index,
    required this.restaurant,
  });

  @override
  State<HomeDetailsPage> createState() => _HomeDetailsPageState();
}

class _HomeDetailsPageState extends State<HomeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseUserApp(
      title: widget.restaurant.restaurantName.toUpperCase(),
      isMainPage: false,
      child: BlocListener<AddToCartCubit, AddToCartState>(
        listener: (context, state) async {
          if (state is AddToCartError) {
            DialogService.showMessage(
              title: "Error",
              message: state.message,
              icon: Icons.error,
              width: width,
              context: context,
            );
          }

          if (state is AddToCartSuccessful) {
            DialogService.showMessage(
              title: "Added to Cart",
              icon: Icons.check,
              width: width,
              context: context,
            );

            await context.read<UserInfoCubit>().userInfo();
          }
        },
        child: Expanded(
          child: widget.restaurant.menuList.isNotEmpty
              ? GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: widget.restaurant.menuList.length,
                  itemBuilder: (context, index) => HomeDetailsCard(
                    menu: widget.restaurant.menuList[index],
                    restaurant: widget.restaurant,
                  ),
                )
              : ListView(
                  children: const [
                    Center(
                      child: Text("No menu yet."),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
