import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_widgets/t_widgets.dart';

void showTAlertDialog(
  BuildContext context, {
  required Widget content,
  bool scrollable = true,
  bool barrierDismissible = true,
  Widget? title,
  TextStyle? titleTextStyle,
  List<Widget>? actions,
  VoidCallback? onCancel,
  VoidCallback? onSubmit,
}) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => TAlertDialog(
      content: content,
      scrollable: scrollable,
      title: title,
      titleTextStyle: titleTextStyle,
      actions: actions,
      onCancel: onCancel,
      onSubmit: onSubmit,
    ),
  );
}

void showTConfirmDialog(
  BuildContext context, {
  required String contentText,
  required void Function() onSubmit,
  Color? color,
  String title = 'Confirm',
  String cancelText = 'Cancel',
  String submitText = 'Submit',
  void Function()? onCancel,
  bool barrierDismissible = true,
}) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => TConfirmDialog(
      contentText: contentText,
      onSubmit: onSubmit,
      onCancel: onCancel,
      cancelText: cancelText,
      submitText: submitText,
      title: title,
    ),
  );
}

void showTReanmeDialog(
  BuildContext context, {
  required String text,
  required void Function(String text) onSubmit,
  Color? color,
  Widget? title,
  String cancelText = 'Cancel',
  String submitText = 'Submit',
  void Function()? onCancel,
  bool barrierDismissible = true,
  Widget? labelText,
  void Function(String text)? onChanged,
  TextInputType? textInputType,
  List<TextInputFormatter>? inputFormatters,
  String? Function(String text)? onCheckIsError,
  bool autofocus = false,
  String? hintText,
}) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => TRenameDialog(
      autofocus: autofocus,
      inputFormatters: inputFormatters,
      onCheckIsError: onCheckIsError,
      onChanged: onChanged,
      renameLabelText: labelText,
      textInputType: textInputType,
      title: title,
      text: text,
      onSubmit: onSubmit,
      onCancel: onCancel,
      cancelText: cancelText,
      submitText: submitText,
      hintText: hintText,
    ),
  );
}

// modal
void showTModalBottomSheet(
  BuildContext context, {
  required Widget child,
  double minHeight = 150,
  bool isScrollControlled = false,
  bool useSafeArea = false,
  bool isDismissible = true,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: isScrollControlled,
    useSafeArea: useSafeArea,
    isDismissible: isDismissible,
    builder: (context) => SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: child,
      ),
    ),
  );
}

void showTMenuBottomSheet(
  BuildContext context, {
  required List<Widget> children,
  double minHeight = 150,
  bool isScrollControlled = false,
  bool useSafeArea = false,
  bool isDismissible = true,
  Widget? title,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: isScrollControlled,
    useSafeArea: useSafeArea,
    isDismissible: isDismissible,
    builder: (context) =>
        MenuBottomSheet(minHeight: minHeight, title: title, children: children),
  );
}

// list dialog
void showTListDialog<T>(
  BuildContext context, {
  required List<T> list,
  required ItemListBuilderCallback<T> listItemBuilder,
  SeparatorBuilderCallback? separatorBuilder,
  bool barrierDismissible = true,
  double height = 200,
  void Function()? onSubmit,
  void Function()? onClose,
  Widget? closeText,
  Widget? submitText,
  EdgeInsetsGeometry? contentPadding,
  Widget? title,
}) {
  showCupertinoDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => TListDialog<T>(
      list: list,
      listItemBuilder: listItemBuilder,
      height: height,
      onClose: onClose,
      onSubmit: onSubmit,
      closeText: closeText,
      contentPadding: contentPadding,
      separatorBuilder: separatorBuilder,
      submitText: submitText,
      title: title,
    ),
  );
}
