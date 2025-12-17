import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t_client/t_client.dart';
import 'package:t_widgets/internal.dart';
import 'package:t_widgets/progress_manager/progress_dialog.dart';
import 'package:t_widgets/progress_manager/progress_manager_interface.dart';
import 'package:t_widgets/progress_manager/progress_message.dart';
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
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin example app')),
      body: Center(
        child: TCacheImage(
          url:
              'https://help.imgur.com/hc/article_attachments/26512175039515?utm_source=chatgpt.com',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showProgressDialog(
            context: context,
            progressManager: ProgressManager(),
          );
          showAdaptiveDialog(
            context: context,
            builder: (context) =>
                ProgressDialog(progressManager: ProgressManager()),
          );
        },
      ),
    );
  }
}

class ProgressManager extends ProgressManagerInterface {
  bool isCancel = false;
  @override
  void cancel() {
    isCancel = true;
  }

  @override
  Future<void> start(StreamController<ProgressMessage> streamController) async {
    await Future.delayed(Duration(milliseconds: 1000));
    streamController.add(ProgressMessage.preparing());

    await Future.delayed(Duration(milliseconds: 1400));

    for (int i = 0; i <= 100; i++) {
      if (isCancel) {
        // await streamController.close();
        streamController.addError('Cancel');
        break;
      }
      await Future.delayed(Duration(milliseconds: 100));

      streamController.add(
        ProgressMessage.progress(
          index: i,
          indexLength: 100,
          progress: i / 100,
          message: 'Progress: $i',
        ),
      );
    }
    if (isCancel) return;

    streamController.add(ProgressMessage.done());

    await Future.delayed(Duration(milliseconds: 1400));

    await streamController.close();
  }
}
