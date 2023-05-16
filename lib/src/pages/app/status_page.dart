import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_ordering_app/src/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/entities/user/user.dart';
import 'package:flutter_food_ordering_app/src/widgets/widgets.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return BaseApp(
      title: "ORDER",
      isMainPage: true,
      child: Expanded(
        child: CustomRefresh(
          onRefresh: _onRefresh,
          child: BlocBuilder<UserInfoCubit, UserEntity>(
            builder: (context, user) {
              if (user.order.isEmpty) {
                return ListView(
                  children: const [
                    Center(
                      child: Text("Your order is empty. Check your cart!"),
                    ),
                  ],
                );
              }
              return ListView.builder(
                itemCount: user.order.length,
                itemBuilder: (context, index) => OrderCard(
                  order: user.order[index],
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
