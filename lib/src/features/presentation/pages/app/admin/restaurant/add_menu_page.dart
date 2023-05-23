import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/domain/entities/entities.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class AddMenuPage extends StatefulWidget {
  final RestaurantEntity restaurant;

  const AddMenuPage({super.key, required this.restaurant});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  final TextEditingController _menuNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _validator = InputValidator();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseAdminApp(
      title: "ADD MENU",
      isMainPage: false,
      child: BlocListener<AddMenuCubit, AddMenuState>(
        listener: (context, state) {
          if (state is AddMenuError) {
            DialogService.showMessage(
              title: "Log In Error",
              message: state.message,
              icon: Icons.error,
              width: width,
              context: context,
            );
          }

          if (state is AddMenuSuccessful) {
            DialogService.showMessage(
              title: "Menu added.",
              icon: Icons.check,
              width: width,
              context: context,
            );

            context.read<AdminInfoCubit>().adminInfo();
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              child: Column(
                children: [
                  InputFieldWidget(
                    label: 'Menu Name',
                    hint: 'Enter menu name',
                    textController: _menuNameController,
                    inputType: TextInputType.text,
                    isObscure: false,
                    validate: _validator.emptyValidation,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: InputFieldWidget(
                      label: 'Nutritional info',
                      hint: 'Enter description',
                      textController: _descriptionController,
                      inputType: TextInputType.text,
                      isObscure: false,
                      validate: _validator.emptyValidation,
                    ),
                  ),
                  InputFieldWidget(
                    label: 'Price',
                    hint: 'Enter price',
                    textController: _priceController,
                    inputType: TextInputType.number,
                    isObscure: false,
                    validate: _validator.emptyValidation,
                  ),
                  BlocSelector<AddMenuCubit, AddMenuState, bool>(
                    selector: (state) {
                      if (state is AddMenuLoading) {
                        return true;
                      }

                      return false;
                    },
                    builder: (context, isLoading) {
                      if (isLoading) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColor.primaryColor,
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            _addMenu(
                              restaurantId: widget.restaurant.restaurantId,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            fixedSize: Size(width, 40),
                          ),
                          child: const Text('ADD'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addMenu({required String restaurantId}) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    final String menuName = _menuNameController.text.trim().toTitleCase();
    final String description = _descriptionController.text.trim();
    final double price = double.parse(_priceController.text.trim());

    await context.read<AddMenuCubit>().addMenu(
          restaurantId: restaurantId,
          menuName: menuName,
          description: description,
          price: price,
        );

    _menuNameController.clear();
    _descriptionController.clear();
    _priceController.clear();
  }
}
