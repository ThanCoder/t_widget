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

  Widget _getLoaderWidget(BuildContext context) {
    return TLoaderTypes.getLoaderWidget(
      types,
      loaderSize: size,
      color: _getCurrentColor(context),
    );
  }

  Color _getCurrentColor(BuildContext context) {
    if (color != null) {
      return color!;
    }
    if (isDarkMode != null) {
      return isDarkMode! ? Colors.white : Colors.black;
    }
    if (TWidgets.instance.isDarkTheme == null) {
      return Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black;
    } else {
      final isDark = TWidgets.instance.isDarkTheme?.call() ?? false;
      return isDark ? Colors.white : Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _getLoaderWidget(context);
  }
}
