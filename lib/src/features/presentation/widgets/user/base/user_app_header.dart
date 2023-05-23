import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/pages/pages.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/widgets/widgets.dart';

class UserAppHeader extends StatefulWidget {
  final String title;
  final bool isMainPage;

  const UserAppHeader({
    super.key,
    required this.title,
    required this.isMainPage,
  });

  @override
  State<UserAppHeader> createState() => _UserAppHeaderState();
}

class _UserAppHeaderState extends State<UserAppHeader> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    bool isMainPage = widget.isMainPage;
    String title = widget.title;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        color: AppColor.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Stack(
            alignment: Alignment.center,
            children: [
              !isMainPage && title != "PAYMENT"
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppColor.backgroundColor,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: width * 0.6,
                  child: Center(
                    child: Padding(
                      padding: title == "PAYMENT"
                          ? const EdgeInsets.symmetric(vertical: 10)
                          : const EdgeInsets.all(0),
                      child: Text(
                        title,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColor.backgroundColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              isMainPage
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: _openCart,
                        icon: const CartIcon(),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openCart() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CartPage(),
      ),
    );
  }
}
