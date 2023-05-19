import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';

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
      children: [
        GestureDetector(
          child: Container(
              padding: const EdgeInsets.all(15),
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: AppColor.primaryColor,
              ),
              child: const Text(
                "-",
                style: TextStyle(
                  fontSize: 24,
                  color: AppColor.secondaryColor,
                ),
              )),
          onTap: () {
            int currentValue =
                int.tryParse(widget.quantityController.text) ?? 0;
            widget.quantityController.text =
                (currentValue > 0) ? "${currentValue - 1}" : "0";
          },
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          width: 50,
          child: TextField(
            controller: widget.quantityController,
            maxLength: 3,
            textAlign: TextAlign.center,
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
              padding: const EdgeInsets.all(12),
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: AppColor.primaryColor,
              ),
              child: const Text(
                "+",
                style: TextStyle(
                  fontSize: 24,
                  color: AppColor.secondaryColor,
                ),
              )),
          onTap: () {
            int currentValue =
                int.tryParse(widget.quantityController.text) ?? 0;
            widget.quantityController.text = "${currentValue + 1}";
          },
        ),
      ],
    );
  }
}
