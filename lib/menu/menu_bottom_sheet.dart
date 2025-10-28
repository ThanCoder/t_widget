import 'package:flutter/material.dart';

class MenuBottomSheet extends StatelessWidget {
  final Widget? title;
  final List<Widget> children;
  final double minHeight;
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsetsGeometry padding;
  const MenuBottomSheet({
    super.key,
    required this.children,
    this.title,
    this.minHeight = 150,
    this.spacing = 0.0,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.padding = const EdgeInsets.all(0.0),
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: Column(
          children: [
            _getHeader(),
            Padding(
              padding: padding,
              child: Column(
                spacing: spacing,
                crossAxisAlignment: crossAxisAlignment,
                mainAxisAlignment: mainAxisAlignment,
                children: children,
              ),
            ),
          ],
        ),
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
