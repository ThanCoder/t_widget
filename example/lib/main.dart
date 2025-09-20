import 'dart:async';
import 'dart:io';

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
      body: Center(child: TImage(source: '')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (context) => TMultiDownloaderDialog(
          //     manager: DownloadManager(),
          //     urls: [
          //       'http://10.37.17.103:9000/download?path=/storage/emulated/0/Movies/Neon/Neon.mp4',
          //     ],
          //   ),
          // );
          final name = 'than';
          name;
          
          // final path = '/home/than/Videos';
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (context) => TMultiUploaderDialog(
          //     manager: UploadManager(),
          //     pathList: ['$path/test.mp4'],
          //   ),
          // );
        },
      ),
    );
  }
}

