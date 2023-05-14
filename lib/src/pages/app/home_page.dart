import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BaseApp(
      title: "ORDER",
      isMainPage: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: const [
            TextField(
              cursorColor: AppColor.primaryColor,
              decoration: InputDecoration(
                fillColor: AppColor.backgroundColor,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primaryColor),
                ),
                hintText: "Search...",
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
