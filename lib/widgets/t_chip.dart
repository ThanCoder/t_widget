import 'package:flutter/material.dart';

class TChip extends StatelessWidget {
  Widget title;
  Widget? avatar;
  Color? backgroundColor;
  void Function()? onClick;
  void Function()? onDelete;
  TChip({
    super.key,
    required this.title,
    this.backgroundColor,
    this.avatar,
    this.onClick,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Chip(
        backgroundColor: backgroundColor,
        mouseCursor: SystemMouseCursors.click,
        deleteIconColor: Colors.red[900],
        label: title,
        avatar: avatar,
        onDeleted: onDelete,
        
      ),
    );
  }
}
