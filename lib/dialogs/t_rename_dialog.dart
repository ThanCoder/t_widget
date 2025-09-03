import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/index.dart';

class TRenameDialog extends StatefulWidget {
  final Widget? title;
  final String text;
  final String cancelText;
  final String submitText;
  final void Function()? onCancel;
  final void Function(String text) onSubmit;
  final Widget? renameLabelText;
  final void Function(String text)? onChanged;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String text)? onCheckIsError;
  final bool autofocus;
  final String? hintText;

  const TRenameDialog({
    super.key,
    this.title,
    this.text = 'Untitled',
    this.cancelText = 'Cancel',
    this.submitText = 'Submit',
    this.onCancel,
    required this.onSubmit,
    this.renameLabelText,
    this.onChanged,
    this.inputFormatters,
    this.textInputType,
    this.onCheckIsError,
    this.autofocus = false,
    this.hintText,
  });

  @override
  State<TRenameDialog> createState() => _TRenameDialogState();
}

class _TRenameDialogState extends State<TRenameDialog> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.text;
    _checkError(controller.text);
    super.initState();
  }

  bool isSelectAll = false;
  String? errorText;

  void _checkError(String value) {
    if (value.isEmpty) {
      setState(() {
        errorText = 'required field';
      });
      return;
    } else {
      if (widget.onCheckIsError != null) {
        final text = widget.onCheckIsError!(value);
        setState(() {
          errorText = text;
        });
        return;
      }
      setState(() {
        errorText = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isSelectAll = false;
      },
      child: AlertDialog(
        title: widget.title,
        content: TTextField(
          controller: controller,
          inputFormatters: widget.inputFormatters,
          textInputType: widget.textInputType,
          label: widget.renameLabelText,
          autofocus: widget.autofocus,
          errorText: errorText,
          hintText: widget.hintText,
          onChanged: (value) {
            _checkError(value);
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          onTap: () {
            if (!isSelectAll) {
              controller.selection = TextSelection(
                baseOffset: 0,
                extentOffset: controller.text.length,
              );
              isSelectAll = true;
            }
          },
          onSubmitted: (value) {
            if (errorText == null) {
              Navigator.pop(context);
              widget.onSubmit(value);
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
              if (widget.onCancel != null) {
                widget.onCancel!();
              }
            },
            child: Text(widget.cancelText),
          ),
          TextButton(
            onPressed:
                errorText != null
                    ? null
                    : () {
                      Navigator.of(context).pop(true);
                      widget.onSubmit(controller.text);
                    },
            child: Text(widget.submitText),
          ),
        ],
      ),
    );
  }
}
