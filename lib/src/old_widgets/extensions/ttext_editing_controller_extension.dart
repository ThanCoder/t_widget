import 'package:flutter/material.dart';

extension TTextEditingControllerExtension on TextEditingController {
  /// Select all Text
  void selectAll() {
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }

  /// Collapses the selection to a single cursor point at the end of the text
  void unselectAll() {
    selection = TextSelection.collapsed(offset: text.length);
  }
}
