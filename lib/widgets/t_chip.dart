import 'package:flutter/material.dart';

class TChip extends StatelessWidget {
  Widget title;
  Widget? avatar;
  void Function()? onClick;
  void Function()? onDelete;
  TChip({
    super.key,
    required this.title,
    this.avatar,
    this.onClick,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Chip(
        mouseCursor: SystemMouseCursors.click,
        deleteIconColor: Colors.red[900],
        label: title,
        avatar: avatar,
        onDeleted: onDelete,
        
      ),
    );
  }
}
