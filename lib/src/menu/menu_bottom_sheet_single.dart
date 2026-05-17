import 'package:flutter/material.dart';

class MenuBottomSheetSingle extends StatelessWidget {
  final Widget? title;
  final Widget child;
  final double minHeight;
  const MenuBottomSheetSingle({
    super.key,
    required this.child,
    this.title,
    this.minHeight = 150,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: Column(children: [_getHeader(), child]),
      ),
    );
  }

  Widget _getHeader() {
    if (title != null) {
      return Column(
        children: [
          Padding(padding: const EdgeInsets.all(8.0), child: title!),
          const Divider(),
        ],
      );
    }
    return SizedBox.shrink();
  }
}
