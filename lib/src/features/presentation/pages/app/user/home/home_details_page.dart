import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class HomeDetailsPage extends StatefulWidget {
  final int index;
  final String restaurantId;
  final String restaurantName;

  const HomeDetailsPage({
    super.key,
    required this.index,
    required this.restaurantId,
    required this.restaurantName,
  });

  @override
  State<HomeDetailsPage> createState() => _HomeDetailsPageState();
}

class _HomeDetailsPageState extends State<HomeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseUserApp(
      title: widget.restaurantName.toUpperCase(),
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
          child: CustomRefresh(
            onRefresh: _onRefresh,
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) {
                  final menuList = state.restaurantList[widget.index].menuList;

                  if (menuList.isEmpty) {
                    return ListView(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Text("No menu yet."),
                          ),
                        ),
                      ],
                    );
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: menuList.length,
                    itemBuilder: (context, index) => HomeDetailsCard(
                      menu: menuList[index],
                      restaurantName: widget.restaurantName,
                      restaurantId: widget.restaurantId,
                    ),
                  );
                }

                if (state is HomeSearched) {
                  final menuList =
                      state.searchedRestaurant[widget.index].menuList;

                  if (menuList.isEmpty) {
                    return ListView(
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Text("No menu yet."),
                          ),
                        ),
                      ],
                    );
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: menuList.length,
                    itemBuilder: (context, index) => HomeDetailsCard(
                      menu: menuList[index],
                      restaurantName: widget.restaurantName,
                      restaurantId: widget.restaurantId,
                    ),
                  );
                }

                return ListView(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text("No menu yet."),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await context.read<HomeCubit>().homeDefault();
  }
}
