import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseApp(
      title: "HOME",
      isMainPage: true,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: TextField(
              controller: _queryController,
              cursorColor: AppColor.primaryColor,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: _onSearch,
                  icon: const Icon(Icons.search),
                ),
                suffixIconColor: AppColor.primaryColor,
                fillColor: AppColor.backgroundColor,
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primaryColor),
                ),
                hintText: "Search Restaurant or Menu...",
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
              ),
              onSubmitted: (_) async {
                _onSearch();
              },
              onChanged: (value) async {
                if (value.isEmpty) {
                  await context.read<HomeCubit>().homeDefault();
                }
              },
            ),
          ),
          CustomRefresh(
            onRefresh: _onRefresh,
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoaded) {
                  if (state.restaurantList.isEmpty) {
                    return ListView(
                      shrinkWrap: true,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Text("No restaurant or menu available yet."),
                          ),
                        ),
                      ],
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 115,
                    ),
                    itemCount: state.restaurantList.length,
                    itemBuilder: (context, index) => HomeCard(
                      restaurant: state.restaurantList[index],
                      index: index,
                    ),
                  );
                }

                if (state is HomeSearched) {
                  if (state.searchedRestaurant.isEmpty) {
                    return ListView(
                      shrinkWrap: true,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Text("No restaurant or menu found."),
                          ),
                        ),
                      ],
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 115,
                    ),
                    itemCount: state.searchedRestaurant.length,
                    itemBuilder: (context, index) => HomeCard(
                      restaurant: state.searchedRestaurant[index],
                      index: index,
                    ),
                  );
                }

                if (state is HomeLoading) {
                  return const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  );
                }

                return ListView(
                  shrinkWrap: true,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text("Nothing to show."),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onRefresh() async {
    await context.read<HomeCubit>().homeDefault();
    _queryController.clear();
  }

  Future<void> _onSearch() async {
    await context.read<HomeCubit>().homeSearched(query: _queryController.text);

    FocusManager.instance.primaryFocus?.unfocus();
  }
}
