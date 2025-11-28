import 'dart:async';

import 'package:flutter/material.dart';
import 'package:t_client/t_client.dart';
import 'package:t_widgets/internal.dart';
import 'package:t_widgets/t_widgets.dart';

void main() async {
  final client = TClient();

  await TWidgets.instance.init(
    initialThemeServices: true,
    defaultImageAssetsPath: 'assets/thancoder_logo_1.png',
    getCachePath: (url) =>
        '/home/than/projects/plugins/t_widget/example/.cache/1234-${url.getName()}.png',
    onDownloadImage: (url, savePath) async {
      await client.download(url, savePath: savePath);
    },
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
    return ThemeModeListener(
      builder: (context, themeMode) => MaterialApp(
        themeMode: themeMode,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(title: const Text('Plugin example app')),
          body: Center(child: TImageAsset(assetPath: 'assets/cover.png')),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              TThemeServices.instance.checkCurrentTheme();
            },
          ),
        ),
      ),
    );
  }
}

class ProgressManager extends TProgressManagerSimple {
  bool isCancel = false;
  @override
  void cancel() {
    isCancel = true;
  }

  @override
  Future<void> startWorking(StreamController<TProgress> controller) async {
    try {
      controller.add(TProgress.preparing(indexLength: 100));

      await Future.delayed(Duration(seconds: 1));

      for (var i = 0; i <= 100; i++) {
        if (isCancel) {
          controller.addError('progress cancel');
          break;
        }
        controller.add(
          TProgress.progress(
            index: 1,
            indexLength: 1,
            loaded: i,
            total: 100,
            message: 'Progress: $i',
          ),
        );
        await Future.delayed(Duration(milliseconds: 100));
      }
      await controller.close();
    } catch (e) {
      controller.addError(e);
    }
  }
}
