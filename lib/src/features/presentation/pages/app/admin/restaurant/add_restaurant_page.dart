import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/core/utils/utils.dart';
import 'package:order_me/src/features/presentation/bloc/app/app.dart';
import 'package:order_me/src/features/presentation/widgets/widgets.dart';

class AddRestaurantPage extends StatefulWidget {
  const AddRestaurantPage({super.key});

  @override
  State<AddRestaurantPage> createState() => _AddRestaurantPageState();
}

class _AddRestaurantPageState extends State<AddRestaurantPage> {
  final TextEditingController _resNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _validator = InputValidator();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseAdminApp(
      title: "ADD RESTAURANT",
      isMainPage: false,
      child: BlocListener<AddRestaurantCubit, AddRestaurantState>(
        listener: (context, state) {
          if (state is AddRestaurantError) {
            DialogService.showMessage(
              title: "Log In Error",
              message: state.message,
              icon: Icons.error,
              width: width,
              context: context,
            );
          }

          if (state is AddRestaurantSuccessful) {
            DialogService.showMessage(
              title: "Restaurant added.",
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
                    label: 'Restaurant Name',
                    hint: 'Enter restaurant name',
                    textController: _resNameController,
                    inputType: TextInputType.text,
                    isObscure: false,
                    validate: _validator.emptyValidation,
                  ),
                  BlocSelector<AddRestaurantCubit, AddRestaurantState, bool>(
                    selector: (state) {
                      if (state is AddRestaurantLoading) {
                        return true;
                      }

                      return false;
                    },
                    builder: (context, isLoading) {
                      if (isLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(10),
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
                          onPressed: _addRestaurant,
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

  Future<void> _addRestaurant() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    final String restaurantName = _resNameController.text.trim().toTitleCase();

    await context
        .read<AddRestaurantCubit>()
        .addRestaurant(restaurantName: restaurantName);

    _resNameController.clear();
  }
}
