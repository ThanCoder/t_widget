import 'package:flutter/material.dart';

class TConfirmDialog extends StatelessWidget {
  String title;
  String contentText;
  String cancelText;
  String submitText;
  void Function()? onCancel;
  void Function() onSubmit;
  TConfirmDialog({
    super.key,
    this.title = 'Confirm',
    required this.contentText,
    this.cancelText = 'Cancel',
    this.submitText = 'Submit',
    this.onCancel,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(contentText),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
            if (onCancel != null) {
              onCancel!();
            }
          },
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            onSubmit();
          },
          child: Text(submitText),
        ),
      ],
    );
  }
}
