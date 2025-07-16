import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TNumberField extends StatelessWidget {
  TextEditingController? controller;
  Widget? label;
  FocusNode? focusNode;
  int? maxLines;
  bool autofocus;
  bool? enabled;
  void Function(String text)? onChanged;
  void Function(String text)? onSubmitted;
  TNumberField({
    super.key,
    this.controller,
    this.label,
    this.focusNode,
    this.maxLines = 1,
    this.onChanged,
    this.onSubmitted,
    this.autofocus=false,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      maxLines: maxLines,
      autofocus: autofocus,
      enabled:enabled ,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        label: label,
      ),
    );
  }
}