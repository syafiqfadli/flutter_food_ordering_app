import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/pages/pages.dart';

class AdminAppHeader extends StatefulWidget {
  final String title;
  final bool isMainPage;
  final RestaurantEntity? restaurant;

  const AdminAppHeader({
    super.key,
    required this.title,
    required this.isMainPage,
    this.restaurant,
  });

  @override
  State<AdminAppHeader> createState() => _AdminAppHeaderState();
}

class _AdminAppHeaderState extends State<AdminAppHeader> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        color: AppColor.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Stack(
            alignment: Alignment.center,
            children: [
              !widget.isMainPage
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColor.backgroundColor,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: width * 0.6,
                  child: Center(
                    child: Padding(
                      padding: widget.title != "RESTAURANT"
                          ? const EdgeInsets.symmetric(vertical: 10)
                          : const EdgeInsets.all(0),
                      child: Text(
                        widget.title,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              (widget.title == "RESTAURANT" || widget.title == "MENU")
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: () {
                          _addNavigator(widget.title);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: AppColor.backgroundColor,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addNavigator(String title) async {
    await context.read<AdminInfoCubit>().adminInfo();

    if (!mounted) return;

    if (title == "RESTAURANT") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AddRestaurantPage(),
        ),
      );

      return;
    }

    if (title == "MENU") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddMenuPage(restaurant: widget.restaurant!),
        ),
      );

      return;
    }
  }
}
