import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/src/core/utils/utils.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';
import 'package:order_me/src/features/presentation/pages/app/user/user_app_page.dart';
import 'package:order_me/src/features/presentation/widgets/widgets.dart';

class PaymentStatusPage extends StatefulWidget {
  const PaymentStatusPage({super.key});

  @override
  State<PaymentStatusPage> createState() => _PaymentStatusPageState();
}

class _PaymentStatusPageState extends State<PaymentStatusPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BaseUserApp(
      title: "PAYMENT",
      isMainPage: false,
      child: Expanded(
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Your payment is successful!",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ElevatedButton(
                  onPressed: _navigateToAppPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    fixedSize: Size(width, 50),
                  ),
                  child: const Text('DONE'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToAppPage() {
    context.read<SetPageUserCubit>().setIndex(0);

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const UserAppPage(),
      ),
      (route) => false,
    );
  }
}
