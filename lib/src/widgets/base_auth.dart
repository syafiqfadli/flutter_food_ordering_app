import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/pages/pages.dart';
import 'package:flutter_food_ordering_app/src/utils/utils.dart';

class BaseAuth extends StatefulWidget {
  final String title;
  final Widget child;
  const BaseAuth({super.key, required this.title, required this.child});

  @override
  State<BaseAuth> createState() => _BaseAuthState();
}

class _BaseAuthState extends State<BaseAuth> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
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
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const WelcomePage(),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                              ),
                            ),
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
