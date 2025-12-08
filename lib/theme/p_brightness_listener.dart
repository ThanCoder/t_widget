import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:t_widgets/theme/p_brightness_services.dart';

typedef PBrightnessListenerBuilder =
    Widget Function(BuildContext context, Brightness brightness);
typedef PBrightnessListenerOnChangeCallback =
    void Function(Brightness brightness);

class PBrightnessListener extends StatefulWidget {
  final PBrightnessListenerBuilder builder;
  final PBrightnessListenerOnChangeCallback onChanged;
  const PBrightnessListener({
    super.key,
    required this.builder,
    required this.onChanged,
  });

  @override
  State<PBrightnessListener> createState() => _PBrightnessListenerState();
}

class _PBrightnessListenerState extends State<PBrightnessListener> {
  late StreamSubscription<Brightness> _streamSubscription;
  late Brightness _brightness = PBrightnessServices.instance.currentBrightness;
  @override
  void initState() {
    _streamSubscription = PBrightnessServices.instance.onBrightnessChanged
        .listen((brightness) {
          _brightness = brightness;
          widget.onChanged(brightness);
          setState(() {});
        });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _brightness);
  }
}

extension BrightnessExt on Brightness {
  bool get isDark => this == Brightness.dark;
  bool get isLight => this == Brightness.light;
}
