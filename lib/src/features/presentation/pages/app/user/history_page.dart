import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return const BaseUserApp(
      title: "HISTORY",
      isMainPage: true,
      child: SizedBox.shrink(),
    );
  }
}
