import 'package:flutter/material.dart';

class TFontListWiget extends StatelessWidget {
  int fontSize;
  void Function(int fontSize) onChange;
  EdgeInsetsGeometry? padding;
  BorderRadius? borderRadius;
  int generateFontLength;
  int generateStartFont;
  TextStyle? fontTextStyle;
  Widget? label;
  TFontListWiget({
    super.key,
    required this.fontSize,
    required this.onChange,
    this.generateFontLength = 50,
    this.padding,
    this.generateStartFont = 14,
    this.borderRadius,
    this.fontTextStyle,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    if (label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [label!, _getWidget()],
      );
    }
    return _getWidget();
  }

  Widget _getWidget() {
    return DropdownButton<int>(
      padding: padding ?? const EdgeInsets.all(4),
      borderRadius: borderRadius ?? BorderRadius.circular(4),
      value: fontSize,
      items: getFontList(),
      onChanged: (value) => onChange(value!),
    );
  }

  List<DropdownMenuItem<int>> getFontList() =>
      List.generate(
        generateFontLength,
        (index) => DropdownMenuItem<int>(
          value: index,
          child: Text(
            '$index',
            style: fontTextStyle ?? TextStyle(fontSize: 19),
          ),
        ),
      ).where((i) => i.value! >= generateStartFont).toList();
}
