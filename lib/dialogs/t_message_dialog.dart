import 'package:flutter/material.dart';

class TMessageDialog extends StatelessWidget {
  Widget? title;
  Widget content;
  Color? backgroundColor;
  TMessageDialog({
    super.key,
    this.title,
    required this.content,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      backgroundColor: backgroundColor,
      title: title,
      content: content,
    );
  }
}
