import 'package:flutter/material.dart';
import 'package:t_widgets/theme/t_theme_services.dart';

typedef ThemeModeListenerBuilder =
    Widget Function(BuildContext context, ThemeMode themeMode);

class ThemeModeListener extends StatelessWidget {
  final ThemeModeListenerBuilder builder;
  const ThemeModeListener({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Brightness>(
      initialData: TThemeServices.instance.currentBrightness,
      stream: TThemeServices.instance.onBrightnessChanged,
      builder: (context, snapshot) {
        final brightness = snapshot.data ?? Brightness.light;
        return builder(
          context,
          brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
        );
      },
    );
  }
}
