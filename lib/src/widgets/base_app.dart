import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/utils/utils.dart';

class BaseApp extends StatefulWidget {
  final String title;
  final Widget? leftIcon;
  final Widget rightIcon;
  final Widget child;

  const BaseApp({
    Key? key,
    required this.title,
    this.leftIcon,
    required this.rightIcon,
    required this.child,
  }) : super(key: key);

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 60, 15, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: widget.leftIcon,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: width * 0.6,
                              child: Center(
                                child: Text(
                                  widget.title,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 34,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: widget.rightIcon,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                widget.child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
