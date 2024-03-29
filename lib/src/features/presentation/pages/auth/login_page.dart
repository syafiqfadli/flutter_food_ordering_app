import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/core/utils/utils.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';
import 'package:order_me/src/features/presentation/pages/pages.dart';
import 'package:order_me/src/features/presentation/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _validator = InputValidator();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseAuth(
      title: "Login",
      child: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            DialogService.showMessage(
              title: "Log In Error",
              message: state.message,
              icon: Icons.error,
              width: width,
              context: context,
            );
          }

          if (state is LoginSuccessful) {
            final optionState = context.read<UserOptionCubit>().state;

            if (optionState is UserOptionInitial ||
                optionState is UserOptionIsUser) {
              context.read<UserOptionCubit>().optionSelected(0);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const UserAppPage(),
                ),
                (route) => false,
              );
            }

            if (optionState is UserOptionIsAdmin) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const AdminAppPage(),
                ),
                (route) => false,
              );
            }

            _emailController.clear();
            _passwordController.clear();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: UserOption(),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          onFieldSubmitted: (_) {
                            _login();
                          },
                        ),
                      ),
                      BlocSelector<LoginCubit, LoginState, bool>(
                        selector: (state) {
                          if (state is LoginLoading) {
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
                          return ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              fixedSize: Size(width, 40),
                            ),
                            child: const Text('LOGIN'),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                " Sign Up",
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    await context.read<LoginCubit>().login(email: email, password: password);
  }
}
