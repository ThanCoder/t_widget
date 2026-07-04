import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 't_text_field.dart';

class TNumberField extends StatelessWidget {
  TextEditingController? controller;
  Widget? label;
  FocusNode? focusNode;
  int? maxLines;
  bool autofocus;
  bool? enabled;
  String? hintText;
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
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TTextField(
      controller: controller,
      focusNode: focusNode,
      maxLines: maxLines,
      autofocus: autofocus,
      enabled:enabled ,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textInputType: TextInputType.number,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      label: label,
      hintText:hintText,
    );
  }
}