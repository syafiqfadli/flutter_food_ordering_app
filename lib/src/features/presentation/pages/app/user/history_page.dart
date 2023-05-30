import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';
import 'package:order_me/src/features/presentation/widgets/widgets.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return BaseUserApp(
      title: "HISTORY",
      isMainPage: true,
      child: Expanded(
        child: CustomRefresh(
          onRefresh: _onRefresh,
          child: BlocBuilder<UserInfoCubit, UserEntity>(
            builder: (context, user) {
              if (user.history.isEmpty) {
                return ListView(
                  children: const [
                    Center(
                      child: Text("No history."),
                    ),
                  ],
                );
              }
              return ListView.builder(
                itemCount: user.history.length,
                itemBuilder: (context, index) => HistoryCard(
                  history: user.history[index],
                  index: index,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onRefresh() async {
    await context.read<UserInfoCubit>().userInfo();
  }
}
