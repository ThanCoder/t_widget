import 'package:t_widgets/extensions/double_extension.dart';

extension IntExtension on int {
  String getSizeLabel({int asFixed = 2}) {
    return toDouble().toFileSizeLabel(asFixed: asFixed);
  }
}
