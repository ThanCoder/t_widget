import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

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
    final isDark = TWidgets.instance.getDarkMode();
    return isDark ? Colors.white : Colors.black;

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
