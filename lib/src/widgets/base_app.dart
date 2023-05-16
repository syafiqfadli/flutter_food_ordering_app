import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/bloc/app/user_info_cubit.dart';
import 'package:flutter_food_ordering_app/src/pages/pages.dart';
import 'package:flutter_food_ordering_app/src/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/widgets/widgets.dart';

class BaseApp extends StatefulWidget {
  final String title;
  final bool isMainPage;
  final Widget child;

  const BaseApp({
    Key? key,
    required this.title,
    required this.isMainPage,
    required this.child,
  }) : super(key: key);

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isMainPage = widget.isMainPage;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Container(
                  color: AppColor.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        !isMainPage
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: AppColor.backgroundColor,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: width * 0.6,
                            child: Center(
                              child: Text(
                                widget.title,
                                maxLines: 1,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.backgroundColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        isMainPage
                            ? Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: _openCart,
                                  icon: const CartIcon(),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
              ),
              widget.child,
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openCart() async {
    await context.read<UserInfoCubit>().userInfo();

    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CartPage(),
      ),
    );
  }
}
