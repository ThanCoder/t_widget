import 'package:file_selector/file_selector.dart';
import 'package:t_widgets/t_widgets.dart';

Future<String?> getDefaultImageChooser({String? initialDirectory}) async {
  try {
    final files = await openFiles(
      initialDirectory: initialDirectory,
      acceptedTypeGroups: [
        const XTypeGroup(
          mimeTypes: ['image/*'],
        ),
      ],
    );
    if (files.isNotEmpty) {
      final path = files.first.path;
      return path;
    }
  } catch (e) {
    TWidgets.showDebugLog(e.toString(), tag: 'getDefaultImageChooser');
    return null;
  }
  return null;
}
