import 'package:flutter/material.dart';

class TConfirmDialog extends StatelessWidget {
  final String title;
  final String contentText;
  final String cancelText;
  final String submitText;
  final void Function()? onCancel;
  final void Function() onSubmit;
  const TConfirmDialog({
    super.key,
    this.title = 'Confirm',
    this.cancelText = 'Cancel',
    this.submitText = 'Submit',
    this.onCancel,
    required this.contentText,
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
