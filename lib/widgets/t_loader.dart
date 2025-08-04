import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

class TLoader extends StatelessWidget {
  double size;
  Color? color;
  bool? isDarkMode;
  TLoaderTypes types;
  TLoader({
    super.key,
    this.size = 50,
    this.color,
    this.isDarkMode,
    this.types = TLoaderTypes.FadingCircle,
  });

  Widget _getLoaderWidget() {
    return TLoaderTypes.getLoaderWidget(
      types,
      loaderSize: size,
      color: _getCurrentColor(),
    );
  }

  Color _getCurrentColor() {
    if (color != null) {
      return color!;
    }
    final isDark = TWidgets.instance.getDarkMode();
    return isDark ? Colors.white : Colors.black;

    // if (TWidgets.instance.getDarkMode != null) {
    //   final isDark = TWidgets.instance.getDarkMode!();
    //   return isDark ? Colors.white : Colors.black;
    // }
    // if (isDarkMode != null) {
    //   return isDarkMode! ? Colors.white : Colors.black;
    // }

    // return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return _getLoaderWidget();
  }
}
