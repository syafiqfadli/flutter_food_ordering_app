import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/features/domain/entities/entities.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';
import 'package:order_me/src/features/presentation/widgets/widgets.dart';

class OrderAdminPage extends StatefulWidget {
  const OrderAdminPage({super.key});

  @override
  State<OrderAdminPage> createState() => _OrderAdminPageState();
}

class _OrderAdminPageState extends State<OrderAdminPage> {
  @override
  Widget build(BuildContext context) {
    return BaseAdminApp(
      title: "ORDER",
      isMainPage: true,
      child: Expanded(
        child: CustomRefresh(
          onRefresh: _onRefresh,
          child: BlocBuilder<AdminInfoCubit, AdminEntity>(
            builder: (context, admin) {
              if (admin.order.isEmpty) {
                return ListView(
                  children: const [
                    Center(
                      child: Text("No one is ordering."),
                    ),
                  ],
                );
              }
              return ListView.builder(
                itemCount: admin.order.length,
                itemBuilder: (context, index) => OrderAdminCard(
                  order: admin.order[index],
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
    await context.read<AdminInfoCubit>().adminInfo();
  }
}
