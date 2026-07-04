import 'package:flutter/material.dart';

class TAlertDialog extends StatefulWidget {
  final Widget content;
  final bool scrollable;
  final Widget? title;
  final TextStyle? titleTextStyle;
  final List<Widget>? actions;
  final VoidCallback? onCancel;
  final VoidCallback? onSubmit;
  const TAlertDialog({
    super.key,
    required this.content,
    this.scrollable = true,
    this.titleTextStyle,
    this.title,
    this.actions,
    this.onCancel,
    this.onSubmit,
  });

  @override
  State<TAlertDialog> createState() => _TAlertDialogState();
}

class _TAlertDialogState extends State<TAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      scrollable: widget.scrollable,
      title: widget.title,
      titleTextStyle: widget.titleTextStyle,
      content: widget.content,
      actions: widget.actions ?? _getActionWidget(),
    );
  }

  List<Widget> _getActionWidget() {
    return [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          widget.onCancel?.call();
        },
        child: Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          widget.onSubmit?.call();
        },
        child: Text('Apply'),
      ),
    ];
  }
}
