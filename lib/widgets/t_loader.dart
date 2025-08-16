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

  static Widget random({double size = 50, Color? color, bool? isDarkMode}) {
    return TLoaderRandom(size: size, color: color, isDarkMode: isDarkMode);
  }

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
  }

  @override
  Widget build(BuildContext context) {
    return _getLoaderWidget();
  }
}
