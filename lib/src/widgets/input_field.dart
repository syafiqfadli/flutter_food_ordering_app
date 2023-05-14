import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/utils/constants.dart';

class InputFieldWidget extends StatelessWidget {
  final bool? enabled;
  final Color? textColor;
  final FocusNode? focusNode;
  final TextEditingController textController;
  final TextInputType inputType;
  final bool isObscure;
  final String? label;
  final String? hint;
  final String? Function(String?)? validate;
  final void Function(String?)? onChanged;

  const InputFieldWidget({
    Key? key,
    required this.textController,
    required this.inputType,
    required this.isObscure,
    this.enabled = true,
    this.textColor = AppColor.textColor,
    this.focusNode,
    this.label,
    this.hint,
    this.validate,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      focusNode: focusNode,
      controller: textController,
      obscureText: isObscure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: onChanged,
      validator: validate,
      keyboardType: inputType,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        fillColor: AppColor.backgroundColor,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        labelText: label,
        hintText: hint,
        errorText: null,
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
