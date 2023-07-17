import 'package:flutter/material.dart';

void showAlertDialog({
  required BuildContext context,
  String? title,
  String? message,
  VoidCallback? onCancel,
  VoidCallback? onSubmit,
}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title ?? ""),
          content: Text(message ?? ""),
          actions: [
            IconButton(
                onPressed: onCancel,
                icon: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                )),
            IconButton(
                onPressed: onSubmit,
                icon: const Icon(
                  Icons.done,
                  color: Colors.green,
                )),
          ],
        );
      });
}