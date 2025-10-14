import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:t_widgets/t_widgets.dart';

enum TThemeModes {
  system,
  light,
  dark;

  bool get isDarkMode {
    return this == dark;
  }

  static TThemeModes getName(String name) {
    if (name == Brightness.light.name) {
      return TThemeModes.light;
    }
    if (name == Brightness.dark.name) {
      return TThemeModes.dark;
    }

    return TThemeModes.system;
  }

  static TThemeModes fromBrightness(Brightness brightness) {
    if (brightness == Brightness.light) {
      return TThemeModes.light;
    }
    if (brightness == Brightness.dark) {
      return TThemeModes.dark;
    }

    return TThemeModes.system;
  }
}

class TThemeServices with WidgetsBindingObserver {
  final _controller = StreamController<TThemeModes>.broadcast();
  Stream<TThemeModes> get onBrightnessChanged => _controller.stream;

  TThemeServices() {
    WidgetsBinding.instance.addObserver(this);
    // init

    Future.delayed(TWidgets.instance.getThemeServicesInitDelay(), () => init());
  }
  void init() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    _controller.add(TThemeModes.fromBrightness(brightness));
  }

  @override
  void didChangePlatformBrightness() {
    final brightness = WidgetsBinding.instance.window.platformBrightness;
    _controller.add(TThemeModes.fromBrightness(brightness));
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.close();
  }
}
