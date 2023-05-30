import 'package:flutter/material.dart';
import 'package:order_me/src/core/utils/utils.dart';
import 'package:order_me/src/features/presentation/pages/pages.dart';

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

    return WillPopScope(
      onWillPop: () {
        _navigateToWelcomePage();

        return Future.value(true);
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: AppColor.backgroundColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 50, 15, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: _navigateToWelcomePage,
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
                    ),
                    widget.child,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToWelcomePage() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const WelcomePage(),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
