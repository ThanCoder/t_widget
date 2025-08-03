import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../t_widgets.dart';

void showTMessageDialogError(
  BuildContext context,
  String message, {
  Widget? title,
}) {
  showCupertinoDialog(
    barrierDismissible: true,
    context: context,
    builder:
        (context) => TMessageDialog(
          backgroundColor: Colors.red,
          title: title,
          content: Text(message, style: TextStyle(color: Colors.white)),
        ),
  );
}

void showTMessageDialog(
  BuildContext context,
  String message, {
  Widget? title,
  Color? color,
}) {
  showCupertinoDialog(
    context: context,
barrierDismissible: true,
    builder:
        (context) => TMessageDialog(
          title: title,
          content: Text(message, style: TextStyle(color: color)),
        ),
  );
}

void showTSnackBarError(
  BuildContext context,
  String message, {
  bool? showCloseIcon,
  SnackBarAction? action,
  DismissDirection? dismissDirection,
  Color? closeIconColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white)),
      showCloseIcon: showCloseIcon,
      action: action,
      dismissDirection: dismissDirection,
      closeIconColor: closeIconColor,
      backgroundColor: Colors.red,
    ),
  );
}

void showTSnackBar(
  BuildContext context,
  String message, {
  Color? color,
  bool? showCloseIcon,
  SnackBarAction? action,
  DismissDirection? dismissDirection,
  Color? closeIconColor,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: color)),
      showCloseIcon: showCloseIcon,
      action: action,
      dismissDirection: dismissDirection,
      closeIconColor: closeIconColor,
      backgroundColor: backgroundColor,
    ),
  );
}
