import 'dart:async';

import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

void main() async {
  await TWidgets.instance.init(defaultImageAssetsPath: 'assets/cover.png');
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
      body: Center(child: TCoverChooser(coverPath: '')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => TProgressDialog(manager: ProgressManager()),
          );
        },
      ),
    );
  }
}

class ProgressManager extends TProgressManager {
  bool isCancel = false;
  @override
  void cancel() {
    isCancel = true;
  }

  @override
  Stream<TProgress> run() {
    final controller = StreamController<TProgress>();
    (() async {
      try {
        controller.add(TProgress.preparing(indexLength: 100));

        await Future.delayed(Duration(seconds: 1));

        for (var i = 0; i <= 100; i++) {
          if (isCancel) {
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
    })();
    return controller.stream;
  }
}
