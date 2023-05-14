import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/widgets/widgets.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return const BaseApp(
      title: "STATUS",
      isMainPage: true,
      child: SizedBox.shrink(),
    );
  }
}
