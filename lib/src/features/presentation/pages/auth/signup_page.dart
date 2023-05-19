import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/pages/auth/login_page.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _validator = InputValidator();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseAuth(
      title: "Sign Up",
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) async {
          if (state is SignUpError) {
            DialogService.showMessage(
              title: "Sign Up Error",
              message: state.message,
              icon: Icons.error,
              width: width,
              context: context,
            );
          }

          if (state is SignUpSuccessful) {
            await DialogService.showMessage(
              title: "Account Created",
              icon: Icons.check,
              width: width,
              context: context,
            );

            if (!mounted) return;

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const LoginPage(),
              ),
              (route) => false,
            );
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: InputFieldWidget(
                      label: 'Name',
                      hint: 'Enter name',
                      validate: _validator.nameValidation,
                      isObscure: false,
                      textController: _nameController,
                      inputType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: InputFieldWidget(
                      label: 'Email',
                      hint: 'Enter email',
                      validate: _validator.emailValidation,
                      isObscure: false,
                      textController: _emailController,
                      inputType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: InputFieldWidget(
                      label: 'Password',
                      hint: 'Enter password',
                      validate: _validator.passwordValidation,
                      isObscure: true,
                      textController: _passwordController,
                      inputType: TextInputType.text,
                    ),
                  ),
                  BlocSelector<SignUpCubit, SignUpState, bool>(
                    selector: (state) {
                      if (state is SignUpLoading) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, isLoading) {
                      if (isLoading) {
                        return const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: AppColor.primaryColor,
                            ),
                          ),
                        );
                      }
                      return ElevatedButton(
                        onPressed: _signup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          fixedSize: Size(width, 40),
                        ),
                        child: const Text('SIGN UP'),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginPage(),
                              ),
                              (route) => false,
                            );
                          },
                          child: const Text(
                            " Log in",
                            style: TextStyle(
                              color: AppColor.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    final String name = _nameController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    await context.read<SignUpCubit>().signUp(
          name: name,
          email: email,
          password: password,
        );
  }
}
