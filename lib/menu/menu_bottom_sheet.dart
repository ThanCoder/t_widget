import 'package:flutter/material.dart';

class MenuBottomSheet extends StatelessWidget {
  Widget? title;
  List<Widget> children;
  double minHeight;
  MenuBottomSheet({
    super.key,
    required this.children,
    this.title,
    this.minHeight = 150,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: Column(children: [_getHeader(), ...children]),
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
