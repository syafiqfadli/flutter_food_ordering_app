import 'package:flutter/material.dart';
import 'package:flutter_food_ordering_app/src/core/utils/utils.dart';

class DialogService {
  static Future showMessage<T>({
    required String title,
    String? message,
    required IconData icon,
    required double width,
    required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Column(
          children: [
            Icon(
              icon,
              size: 45,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            message != null
                ? Text(
                    message,
                    style: const TextStyle(fontSize: 16),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        actions: [
          SizedBox(
            width: width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ),
        ],
      ),
    );
  }

  static Future showDeleteCancel<T>({
    required Function() onDelete,
    required BuildContext context,
  }) async {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Column(
          children: const [
            Icon(
              Icons.delete,
              size: 45,
            ),
            SizedBox(height: 10),
            Text("Are you sure?"),
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    onDelete();
                    Navigator.pop(context);
                  },
                  child: const Text('Delete'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
