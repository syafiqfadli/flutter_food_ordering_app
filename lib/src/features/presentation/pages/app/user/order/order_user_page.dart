import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';
import 'package:order_me/src/features/presentation/widgets/widgets.dart';

class OrderUserPage extends StatefulWidget {
  const OrderUserPage({super.key});

  @override
  State<OrderUserPage> createState() => _OrderUserPageState();
}

class _OrderUserPageState extends State<OrderUserPage> {
  @override
  Widget build(BuildContext context) {
    return BaseUserApp(
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
                itemBuilder: (context, index) => OrderUserCard(
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
