import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/widgets/widgets.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return const BaseApp(
      title: "CART",
      isMainPage: false,
      child: SizedBox.shrink(),
    );
  }
}
