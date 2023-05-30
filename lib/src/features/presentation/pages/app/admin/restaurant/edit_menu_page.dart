import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/core/utils/utils.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';
import 'package:order_me/src/features/presentation/bloc/app/admin/is_edit_cubit.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';
import 'package:order_me/src/features/presentation/widgets/widgets.dart';

class EditMenuPage extends StatefulWidget {
  final RestaurantEntity restaurant;
  final MenuEntity menu;

  const EditMenuPage({
    super.key,
    required this.restaurant,
    required this.menu,
  });

  @override
  State<EditMenuPage> createState() => _EditMenuPageState();
}

class _EditMenuPageState extends State<EditMenuPage> {
  final TextEditingController _menuNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _validator = InputValidator();
  final IsEditCubit isEditCubit = IsEditCubit();

  @override
  void initState() {
    super.initState();
    _menuNameController.text = widget.menu.menuName;
    _descriptionController.text = widget.menu.description;
    _priceController.text = widget.menu.price.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseAdminApp(
      title: "EDIT MENU",
      isMainPage: false,
      child: BlocListener<EditMenuCubit, EditMenuState>(
        listener: (context, state) {
          if (state is EditMenuError) {
            DialogService.showMessage(
              title: "Log In Error",
              message: state.message,
              icon: Icons.error,
              width: width,
              context: context,
            );
          }

          if (state is EditMenuSuccessful) {
            DialogService.showMessage(
              title: "Menu updated.",
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
              child: BlocProvider.value(
                value: isEditCubit,
                child: BlocBuilder<IsEditCubit, bool>(
                  builder: (context, isEdit) {
                    return Column(
                      children: [
                        InputFieldWidget(
                          label: 'Menu Name',
                          hint: 'Enter menu name',
                          textController: _menuNameController,
                          inputType: TextInputType.text,
                          isObscure: false,
                          enabled: isEdit,
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
                            enabled: isEdit,
                            validate: _validator.emptyValidation,
                          ),
                        ),
                        InputFieldWidget(
                          label: 'Price',
                          hint: 'Enter price',
                          textController: _priceController,
                          inputType: TextInputType.number,
                          isObscure: false,
                          enabled: isEdit,
                          validate: _validator.emptyValidation,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: ElevatedButton(
                            onPressed: () {
                              isEditCubit.isEdit();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.secondaryColor,
                              fixedSize: Size(width, 40),
                            ),
                            child: Text(
                              !isEdit ? 'EDIT' : "DONE",
                              style: const TextStyle(color: AppColor.textColor),
                            ),
                          ),
                        ),
                        BlocSelector<EditMenuCubit, EditMenuState, bool>(
                          selector: (state) {
                            if (state is EditMenuLoading) {
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
                            return ElevatedButton(
                              onPressed: !isEdit
                                  ? () {
                                      editMenu(
                                        width,
                                        menuId: widget.menu.menuId,
                                        restaurantId:
                                            widget.restaurant.restaurantId,
                                      );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                                fixedSize: Size(width, 40),
                              ),
                              child: const Text('UPDATE'),
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> editMenu(
    double width, {
    required String restaurantId,
    required String menuId,
  }) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    final String menuName = _menuNameController.text.trim().toTitleCase();
    final String description = _descriptionController.text.trim();
    final double price = double.parse(_priceController.text.trim());

    if (menuName == widget.menu.menuName &&
        description == widget.menu.description &&
        price == widget.menu.price) {
      DialogService.showMessage(
        title: "Update Error",
        message: "No changes have been made.",
        icon: Icons.error,
        width: width,
        context: context,
      );

      return;
    }

    await context.read<EditMenuCubit>().editMenu(
          restaurantId: restaurantId,
          menuId: menuId,
          menuName: menuName,
          description: description,
          price: price,
        );
  }
}
