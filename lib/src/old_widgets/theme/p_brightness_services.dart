import 'dart:async';
import 'package:flutter/widgets.dart';

class PBrightnessServices with WidgetsBindingObserver {
  // singleton
  static final PBrightnessServices instance = PBrightnessServices._();
  PBrightnessServices._();
  factory PBrightnessServices() => instance;

  final _controller = StreamController<Brightness>.broadcast();
  Stream<Brightness> get onBrightnessChanged => _controller.stream;
  Brightness currentBrightness = Brightness.light;

  void init() {
    WidgetsBinding.instance.addObserver(this);
    // initial checkThemeEvent
    checkCurrentTheme();
    // Future.delayed(Duration(milliseconds: 500), checkCurrentTheme);
  }

  @override
  void didChangePlatformBrightness() {
    checkCurrentTheme();
    super.didChangePlatformBrightness();
  }

  void checkCurrentTheme() {
    // Android <10, Linux မှာ အမြဲ light ဖြစ်နိုင်တယ်
    currentBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    _controller.add(currentBrightness);
  }
}
