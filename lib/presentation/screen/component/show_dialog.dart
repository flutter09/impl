import 'package:flutter/material.dart';

import 'component.dart';

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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(title ?? ""),
          content: Text(message ?? ""),
          actions: [
            defaultTextButton(
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.red ),
              function: (){onCancel?.call();},
              text: 'Cancel',
            ),
            defaultTextButton(
              style: const TextStyle(
                  fontWeight: FontWeight.normal, color: Colors.black ),
              function: (){onSubmit?.call();},
              text: 'Okay',
            ),
            /*IconButton(
                onPressed: onCancel,
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                )),
            IconButton(
                onPressed: onSubmit,
                icon: const Icon(
                  Icons.done,
                  color: Colors.green,
                )),*/
          ],
        );
      });
}