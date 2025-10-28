import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:t_widgets/internal.dart';
import 'package:t_widgets/t_widgets.dart';

void main() async {
  final dio = Dio();

  await TWidgets.instance.init(
    defaultImageAssetsPath: 'assets/cover.png',
    getCachePath: (url) =>
        '/home/than/projects/plugins/t_widget/example/.cache/1234-${url.getName()}.png',
    onDownloadImage: (url, savePath) async {
      await dio.download(url, savePath);
    },
  );
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String url =
      'https://images.pexels.com/photos/1103970/pexels-photo-1103970.jpeg?auto=compress&cs=tinysrgb&w=2000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin example app')),
      body: Center(child: TCacheImage(url: url)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // url =
          //     'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=2000';
          // setState(() {});
          // showDialog(
          //   context: context,
          //   barrierDismissible: false,
          //   builder: (context) => TProgressDialog(manager: ProgressManager()),
          // );
          showTMenuBottomSheetSingle(
            context,
            title: Text('title'),
            child: ListTile(title: Text('list tile')),
          );
          // showTMenuBottomSheet(
          //   context,
          //   title: Text('title'),
          //   // spacing: 20,
          //   children: [
          //     ListTile(
          //       leading: Icon(Icons.favorite),
          //       title: Text('fav'),
          //       onTap: () {
          //         Navigator.pop(context);
          //       },
          //     ),
          //     ListTile(
          //       leading: Icon(Icons.favorite),
          //       title: Text('fav'),
          //       onTap: () {
          //         Navigator.pop(context);
          //       },
          //     ),
          //     ListTile(
          //       leading: Icon(Icons.favorite),
          //       title: Text('fav'),
          //       onTap: () {
          //         Navigator.pop(context);
          //       },
          //     ),
          //   ],
          // );
        },
      ),
    );
  }
}

class ProgressManager extends TProgressManagerSimple {
  @override
  void cancel() {
    // TODO: implement cancel
  }

  @override
  Future<void> startWorking(StreamController<TProgress> controller) {
    // TODO: implement startWorking
    throw UnimplementedError();
  }
}
// class ProgressManager extends TProgressManagerSimple {
//   bool isCancel = false;
//   @override
//   void cancel() {
//     isCancel = true;
//   }

//   @override
//   Future<void> startWorking(StreamController<TProgress> controller) async {
//     try {
//       controller.add(TProgress.preparing(indexLength: 100));

//       await Future.delayed(Duration(seconds: 1));

//       for (var i = 0; i <= 100; i++) {
//         if (isCancel) {
//           controller.addError('progress cancel');
//           break;
//         }
//         controller.add(
//           TProgress.progress(
//             index: 1,
//             indexLength: 1,
//             loaded: i,
//             total: 100,
//             message: 'Progress: $i',
//           ),
//         );
//         await Future.delayed(Duration(milliseconds: 100));
//       }
//       await controller.close();
//     } catch (e) {
//       controller.addError(e);
//     }
//   }
// }
