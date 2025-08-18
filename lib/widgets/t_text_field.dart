import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_widgets/extensions/text_editing_controller_extension.dart';

class TTextField extends StatefulWidget {
  TextEditingController? controller;
  Widget? label;
  String? hintText;
  String? errorText;
  int? maxLines;
  TextInputType? textInputType;
  bool isSelectedAll;
  List<TextInputFormatter>? inputFormatters;
  TextStyle? style;
  FocusNode? focusNode;
  bool autofocus;
  bool? enabled;
  void Function(String value)? onChanged;
  void Function(String value)? onSubmitted;
  void Function()? onTap;

  TTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.label,
    this.hintText,
    this.maxLines = 1,
    this.isSelectedAll = false,
    this.textInputType,
    this.inputFormatters,
    this.errorText,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.style,
    this.autofocus=false,
    this.enabled,
  });

  @override
  State<TTextField> createState() => _TTextFieldState();
}

class _TTextFieldState extends State<TTextField> {
  bool isSelected = false;

  void _selectAll() {
    if (widget.isSelectedAll && widget.controller != null) {
      if (!isSelected) {
        widget.controller!.selectAll();
      }
      isSelected = true;
    } else {
      isSelected = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.textInputType,
      inputFormatters: widget.inputFormatters,
      controller: widget.controller,
      maxLines: widget.maxLines,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      decoration: InputDecoration(
        label: widget.label,
        hintText: widget.hintText,
        border: const OutlineInputBorder(),
        errorText: widget.errorText,
      ),
      style: widget.style,
      onChanged: widget.onChanged,
      onTap: () {
        _selectAll();
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onSubmitted: widget.onSubmitted,
    );
  }
}
