import 'package:flutter/material.dart';
import 'package:order_me/src/core/utils/utils.dart';
import 'package:order_me/src/features/presentation/widgets/widgets.dart';

class BaseUserApp extends StatelessWidget {
  final String title;
  final bool isMainPage;
  final Widget child;

  const BaseUserApp({
    super.key,
    required this.title,
    required this.isMainPage,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SafeArea(
          child: title == "HOME"
              ? SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      UserAppHeader(title: title, isMainPage: isMainPage),
                      child,
                    ],
                  ),
                )
              : Column(
                  children: [
                    UserAppHeader(title: title, isMainPage: isMainPage),
                    child,
                  ],
                ),
        ),
      ),
    );
  }
}
