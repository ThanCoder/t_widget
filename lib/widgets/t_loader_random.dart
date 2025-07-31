import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:t_widgets/types/t_loader_types.dart';

class TLoaderRandom extends StatelessWidget {
  double size;
  Color? color;
  bool? isDarkMode;
  TLoaderRandom({super.key, this.size = 50, this.color, this.isDarkMode});

  Widget _getLoaderWidget() {
    return TLoaderTypes.getRandomLoader(
      loaderSize: size,
      color: _getCurrentColor(),
    );
  }

  Color _getCurrentColor() {
    if (color != null) {
      return color!;
    }
    if (TWidgets.instance.getDarkMode != null) {
      final isDark = TWidgets.instance.getDarkMode!();
      return isDark ? Colors.white : Colors.black;
    }
    if (isDarkMode != null) {
      return isDarkMode! ? Colors.white : Colors.black;
    }

    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return _getLoaderWidget();
  }
}
