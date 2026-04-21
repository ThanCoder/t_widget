import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

final appDarkThemeNotifier = ValueNotifier<bool>(false);

void main() async {
  final cacheDir = Directory('.cache');
  if (!cacheDir.existsSync()) {
    await cacheDir.create();
  }

  await TWidgets.instance.init(
    initialThemeServices: true,
    defaultImageAssetsPath: 'assets/thancoder_logo_1.png',
    getCachePath: (url, cacheName) => '${cacheDir.path}/$cacheName',
    // onCustomDownloadImage: (url, savePath, {onProgress}) async {
    //   await client.download(
    //     url,
    //     savePath: savePath,
    //     onReceiveProgress: (received, total) =>
    //         onProgress?.call(received / total),
    //   );
    // },
    isDarkTheme: () => appDarkThemeNotifier.value,
  );
  runApp(MaterialApp(home: Scaffold(body: const MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //https://help.imgur.com/hc/article_attachments/26512175039515?utm_source=chatgpt.com
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin example app')),
      body: SingleChildScrollView(
        child: Center(child: TCoverChooser(coverPath: '')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showTSnackBar(context, message)
          showTReanmeDialog(context, text: 'test', onSubmit: (text) {});
        },
      ),
    );
  }
}
