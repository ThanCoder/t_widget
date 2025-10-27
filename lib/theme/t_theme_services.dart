import 'dart:async';

import 'package:flutter/widgets.dart';

class TThemeServices with WidgetsBindingObserver {
  static final TThemeServices instance = TThemeServices._();
  TThemeServices._();
  factory TThemeServices() => instance;

  final _controller = StreamController<TThemeModes>.broadcast();
  Stream<TThemeModes> get onBrightnessChanged => _controller.stream;

  void init() {
    WidgetsBinding.instance.addObserver(this);
    // initial checkThemeEvent
    checkThemeEvent();
  }

  void checkThemeEvent() {
    // Android <10, Linux မှာ အမြဲ light ဖြစ်နိုင်တယ်
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    _controller.add(TThemeModes.fromBrightness(brightness));
  }

  @override
  void didChangePlatformBrightness() {
    // OS theme ပြောင်းတာ detect
    checkThemeEvent();
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.close();
  }
}

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
