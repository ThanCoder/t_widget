import 'package:flutter/material.dart';
import 'package:t_widgets/extensions/t_widgets_extensions.dart';

class ConfirmDialog extends StatefulWidget {
  final Widget? title;
  final Widget content;
  final Widget Function(BuildContext context, void Function() callback)?
  cancelButton;
  final Widget Function(BuildContext context)? middleButton;
  final Widget Function(BuildContext context, void Function() callback)?
  submitButton;
  const ConfirmDialog({
    super.key,
    this.title,
    required this.content,
    this.cancelButton,
    this.middleButton,
    this.submitButton,
  });

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      scrollable: true,
      title: widget.title,
      content: widget.content,
      actions: _actions(),
    );
  }

  List<Widget> _actions() {
    return [
      if (widget.cancelButton != null)
        widget.cancelButton!(context, _onCancel)
      else
        TextButton(onPressed: _onCancel, child: Text('Close')),
      if (widget.middleButton != null) widget.middleButton!(context),
      if (widget.submitButton != null)
        widget.submitButton!(context, _onSubmit)
      else
        TextButton(onPressed: _onSubmit, child: Text('Submit')),
    ];
  }

  void _onCancel() {
    context.close();
  }

  void _onSubmit() {
    context.close();
  }
}

class ConfirmBottomSheet extends StatefulWidget {
  final Widget? title;
  final Widget content;
  final Widget Function(BuildContext context, void Function() callback)?
  cancelButton;
  final Widget Function(BuildContext context)? middleButton;
  final Widget Function(BuildContext context, void Function() callback)?
  submitButton;
  const ConfirmBottomSheet({
    super.key,
    this.title,
    required this.content,
    this.cancelButton,
    this.middleButton,
    this.submitButton,
  });

  @override
  State<ConfirmBottomSheet> createState() => _ConfirmBottomSheetState();
}

class _ConfirmBottomSheetState extends State<ConfirmBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 4,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.title ??
                Text(
                  'Confirm',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
            widget.content,
            SizedBox(height: 20),
            _actions(),
          ],
        ),
      ),
    );
  }

  Widget _actions() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 5,
        children: [
          if (widget.cancelButton != null)
            widget.cancelButton!(context, _onCancel)
          else
            TextButton(onPressed: _onCancel, child: Text('Close')),
          if (widget.middleButton != null) widget.middleButton!(context),
          if (widget.submitButton != null)
            widget.submitButton!(context, _onSubmit)
          else
            TextButton(onPressed: _onSubmit, child: Text('Submit')),
        ],
      ),
    );
  }

  void _onCancel() {
    context.close();
  }

  void _onSubmit() {
    context.close();
  }
}
