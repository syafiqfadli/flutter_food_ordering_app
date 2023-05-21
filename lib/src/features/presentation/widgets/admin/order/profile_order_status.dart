import 'package:flutter/material.dart';

class ProfileOrderStatus extends StatelessWidget {
  final Color boxColor;
  final String status;
  final int orderLength;

  const ProfileOrderStatus({
    super.key,
    required this.boxColor,
    required this.status,
    required this.orderLength,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: boxColor,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              status,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              orderLength.toString(),
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
