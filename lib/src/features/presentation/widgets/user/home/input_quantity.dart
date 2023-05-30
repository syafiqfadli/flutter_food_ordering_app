import 'package:flutter/material.dart';
import 'package:order_me/src/core/utils/utils.dart';

class InputQuantity extends StatefulWidget {
  final TextEditingController quantityController;

  const InputQuantity({super.key, required this.quantityController});

  @override
  State<InputQuantity> createState() => _InputQuantityState();
}

class _InputQuantityState extends State<InputQuantity> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: AppColor.primaryColor,
              ),
              child: const Text(
                "-",
                style: TextStyle(
                  fontSize: 26,
                  color: AppColor.backgroundColor,
                ),
              )),
          onTap: () {
            int quantity = int.parse(widget.quantityController.text);

            widget.quantityController.text =
                (quantity > 0) ? "${quantity - 1}" : "0";
          },
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          width: 50,
          child: TextField(
            enabled: false,
            controller: widget.quantityController,
            maxLength: 3,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              hintText: "0",
              border: InputBorder.none,
              counterText: "",
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const ShapeDecoration(
              shape: CircleBorder(),
              color: AppColor.primaryColor,
            ),
            child: const Text(
              "+",
              style: TextStyle(
                fontSize: 26,
                color: AppColor.backgroundColor,
              ),
            ),
          ),
          onTap: () {
            int quantity = int.parse(widget.quantityController.text);

            widget.quantityController.text =
                (quantity < 10) ? "${quantity + 1}" : "10";
          },
        ),
      ],
    );
  }
}
