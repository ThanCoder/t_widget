import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t_client/t_client.dart';
import 'package:t_widgets/internal.dart';
import 'package:t_widgets/t_widgets.dart';

final appDarkThemeNotifier = ValueNotifier<bool>(false);

void main() async {
  final client = TClient();
  final cacheDir = Directory(
    '/home/than/projects/plugins/t_widget/example/.cache',
  );
  if (!cacheDir.existsSync()) {
    await cacheDir.create();
  }

  await TWidgets.instance.init(
    initialThemeServices: true,
    defaultImageAssetsPath: 'assets/thancoder_logo_1.png',
    getCachePath: (url) => '${cacheDir.path}/${url.getName()}.png',
    onDownloadImage: (url, savePath) async {
      await client.download(url, savePath: savePath);
    },
    isDarkTheme: () => appDarkThemeNotifier.value,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return PBrightnessListener(
      onChanged: (brightness) {
        appDarkThemeNotifier.value = brightness.isDark;
        print('brightness: $brightness');
        return false;
      },
      builder: (context, brightness) => MaterialApp(
        themeMode: brightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(title: const Text('Plugin example app')),
          body: Center(
            child: TCacheImage(
              url:
                  'https://help.imgur.com/hc/article_attachments/26512175039515?utm_source=chatgpt.com',
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
