import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../t_widgets.dart';

void showTMessageDialogError(
  BuildContext context,
  String message, {
  Widget? title,
  String? barrierLabel,
  Color? barrierColor,
  bool useRootNavigator = true,
  bool barrierDismissible = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  bool? requestFocus,
}) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    barrierColor: barrierColor,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    requestFocus: requestFocus,
    builder: (context) => TMessageDialog(
      // backgroundColor: Colors.red,
      title: title ?? Text('Error'),
      content: Container(
        color: const Color.fromARGB(255, 216, 54, 42),
        child: SelectableText(message, style: TextStyle(color: Colors.white)),
      ),
    ),
  );
}

void showTMessageDialog(
  BuildContext context,
  String message, {
  Widget? title,
  Color? color,
  String? barrierLabel,
  Color? barrierColor,
  bool useRootNavigator = true,
  bool barrierDismissible = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  bool? requestFocus,
}) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    barrierColor: barrierColor,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    requestFocus: requestFocus,
    builder: (context) => TMessageDialog(
      title: title,
      content: SelectableText(message, style: TextStyle(color: color)),
    ),
  );
}

void showTSnackBarError(
  BuildContext context,
  String message, {
  Color? color,
  bool? showCloseIcon,
  SnackBarAction? action,
  DismissDirection? dismissDirection,
  Color? closeIconColor,
  Color? backgroundColor,
  double? elevation,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  double? width,
  ShapeBorder? shape,
  HitTestBehavior? hitTestBehavior,
  SnackBarBehavior? behavior,
  double? actionOverflowThreshold,
  Duration duration = const Duration(milliseconds: 4000),
  bool? persist,
  Animation<double>? animation,
  void Function()? onVisible,
  Clip clipBehavior = Clip.hardEdge,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white)),
      showCloseIcon: showCloseIcon,
      action: action,
      dismissDirection: dismissDirection,
      closeIconColor: closeIconColor,
      backgroundColor: Colors.red,
      elevation: elevation,
      margin: margin,
      padding: padding,
      width: width,
      shape: shape,
      hitTestBehavior: hitTestBehavior,
      behavior: behavior,
      actionOverflowThreshold: actionOverflowThreshold,
      duration: duration,
      persist: persist,
      animation: animation,
      onVisible: onVisible,
      clipBehavior: clipBehavior,
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
  double? elevation,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  double? width,
  ShapeBorder? shape,
  HitTestBehavior? hitTestBehavior,
  SnackBarBehavior? behavior,
  double? actionOverflowThreshold,
  Duration duration = const Duration(milliseconds: 4000),
  bool? persist,
  Animation<double>? animation,
  void Function()? onVisible,
  Clip clipBehavior = Clip.hardEdge,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: color)),
      showCloseIcon: showCloseIcon,
      action: action,
      dismissDirection: dismissDirection,
      closeIconColor: closeIconColor,
      backgroundColor: backgroundColor,
      elevation: elevation,
      margin: margin,
      padding: padding,
      width: width,
      shape: shape,
      hitTestBehavior: hitTestBehavior,
      behavior: behavior,
      actionOverflowThreshold: actionOverflowThreshold,
      duration: duration,
      persist: persist,
      animation: animation,
      onVisible: onVisible,
      clipBehavior: clipBehavior,
    ),
  );
}
