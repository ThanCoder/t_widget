import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:t_widgets_example/home_screen.dart';


final darkNotifier = ValueNotifier<bool>(false);

void main() async {
  await TWidgets.instance.init(
    defaultImageAssetsPath: 'assets/logo.webp',
    isDebugPrint: true,
    getDarkMode: () => darkNotifier.value,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: darkNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          darkTheme: ThemeData.dark(),
          themeMode: value ? ThemeMode.dark : null,
          home: HomeScreen(),
        );
      },
    );
  }
}

