import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t_client/t_client.dart';
import 'package:t_widgets/downloader/t_multi_uploader_dialog.dart';
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
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => TMultiDownloaderDialog(
              manager: DownloadManager(),
              urls: [
                'http://10.37.17.103:9000/download?path=/storage/emulated/0/Download/Telegram/Dandadan%20S02E09.mp4',
              ],
            ),
          );
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

class DownloadManager extends TDownloadManager {
  final token = TClientToken(isCancelFileDelete: false);
  final client = TClient();
  final savePath = '/home/than/Downloads/personal_server';

  @override
  void cancel() {
    token.cancel();
  }

  @override
  Stream<TProgress> actions(List<String> urls) {
    final controller = StreamController<TProgress>();
    (() async {
      try {
        controller.add(TProgress.preparing(indexLength: urls.length));

        int index = 0;
        for (var url in urls) {
          final name = url.getName();

          index++;
          await client.download(
            url,
            token: token,
            savePath: '$savePath/$name',
            onError: controller.addError,
            // onReceiveProgress: (received, total) {
            //   controller.add(
            //     TProgress.progress(
            //       index: index,
            //       indexLength: urls.length,
            //       message: '$name\n Downloading...',
            //       loaded: received,
            //       total: total,
            //     ),
            //   );
            // },
            onReceiveProgressSpeed: (received, total, speed, eta) {
              controller.add(
                TProgress.progress(
                  index: index,
                  indexLength: urls.length,
                  message:
                      '$name\nDownloading...\n Speed: ${speed.toFileSizeLabel()} Left: ${eta?.toAutoTimeLabel()}',
                  loaded: received,
                  total: total,
                ),
              );
            },
          );
        }

        controller.add(TProgress.done(message: 'Downloaded'));
      } catch (e) {
        controller.addError(e);
      }
    })();
    return controller.stream;
  }
}

class UploadManager extends TUploadManager {
  final token = TClientToken(isCancelFileDelete: true);
  final client = TClient();
  final String apiUrl = 'http://10.37.17.103:9000/upload';

  @override
  void cancel() {
    token.cancel();
  }

  @override
  Stream<TProgress> actions(List<String> pathList) {
    final controller = StreamController<TProgress>();
    (() async {
      try {
        controller.add(TProgress.preparing(indexLength: pathList.length));

        int index = 0;
        for (var path in pathList) {
          final name = path.getName();

          index++;
          await client.upload(
            apiUrl,
            file: File(path),
            token: token,
            onError: controller.addError,
            onCancelCallback: controller.addError,
            onUploadProgress: (sent, total) {
              controller.add(
                TProgress.progress(
                  index: index,
                  indexLength: pathList.length,
                  message: '$name\nUploading...',
                  loaded: sent,
                  total: total,
                ),
              );
            },
          );
        }

        controller.add(TProgress.done(message: 'Uploaded'));
      } catch (e) {
        controller.addError(e);
      }
    })();
    return controller.stream;
  }
}
