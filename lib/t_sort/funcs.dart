import 'package:flutter/material.dart';
import 't_show_sort_types.dart';
import 't_sort.dart';
import 't_sort_dalog.dart';

void showTSortDialog(
  BuildContext context, {
  required TSortDialogCallback sortDialogCallback,
  Widget? sortTitle,
  int? defaultId,
  List<TSort>? sortList,
  bool isAsc = true,
  Color? activeColor,
  Color? activeTextColor,
  TShowSortTypes? showSortType,
  Widget? cancelText,
  Widget? submitText,
}) {
  showAdaptiveDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => TSortDalog(
      sortDialogCallback: sortDialogCallback,
      defaultId: defaultId,
      sortList: sortList,
      sortTitle: sortTitle,
      showSortType: showSortType,
      isAsc: isAsc,
      activeColor: activeColor = Colors.teal,
      activeTextColor: activeTextColor,
      cancelText: cancelText,
      submitText: submitText,
    ),
  );
}
