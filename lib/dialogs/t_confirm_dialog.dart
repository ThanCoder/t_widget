import 'package:flutter/material.dart';

class TConfirmDialog extends StatelessWidget {
  final String? title;
  final String? cancelText;
  final String? submitText;
  final void Function()? onCancel;
  final void Function() onSubmit;
  final String contentText;
  const TConfirmDialog({
    super.key,
    this.title,
    this.cancelText,
    this.submitText,
    this.onCancel,
    required this.contentText,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? 'Confirm'),
      content: Text(contentText),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
            if (onCancel != null) {
              onCancel!();
            }
          },
          child: Text(cancelText ?? 'Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
            onSubmit();
          },
          child: Text(submitText ?? 'Confirm'),
        ),
      ],
    );
  }
}
