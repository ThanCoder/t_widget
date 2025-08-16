import 'dart:io';

extension PlatformExtension on Platform {
  static bool get isDesktop {
    return Platform.isLinux || Platform.isMacOS || Platform.isWindows;
  }

  static bool get isMobile {
    return Platform.isAndroid || Platform.isIOS;
  }
}
