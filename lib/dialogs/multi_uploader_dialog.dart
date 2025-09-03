import 'package:flutter/material.dart';
import 'package:t_widgets/extensions/double_extension.dart';
import 'package:t_widgets/extensions/string_extension.dart';

class MultiUploaderDialog extends StatefulWidget {
  String hostUrl;
  List<String> pathList;
  VoidCallback onSuccess;
  MultiUploaderDialog({
    super.key,
    required this.hostUrl,
    required this.pathList,
    required this.onSuccess,
  });

  @override
  State<MultiUploaderDialog> createState() => _MultiUploaderDialogState();
}

class _MultiUploaderDialogState extends State<MultiUploaderDialog> {
  @override
  void initState() {
    super.initState();
    init();
  }

  // final dio = Dio();
  // final CancelToken cancelToken = CancelToken();
  double fileSize = 0;
  double downloadedSize = 0;
  String progressMsg = 'Preparing...';
  String errorMsg = '';
  int uploadIndex = 0;

  void init() async {

    for (var path in widget.pathList) {
      try {
        progressMsg = 'Uploading... : ${path.getName()}';
        uploadIndex++;
        // final formData = FormData.fromMap({
        //   'file': await MultipartFile.fromFile(path, filename: path.getName()),
        // });
        // await dio.post(
        //   "${widget.hostUrl}/upload",
        //   data: formData,
        //   options: Options(
        //     contentType: 'multipart/form-data',
        //     sendTimeout: Duration(
        //       hours: 1,
        //     ), // 2GB ဆိုတာကြောင့် timeout ကြီးကြီးထား
        //     receiveTimeout: Duration(hours: 1),
        //   ),
        //   onSendProgress: (sent, total) {
        //     if (!mounted) return;
        //     // final percent = (sent / total * 100).toStringAsFixed(2);
        //     setState(() {
        //       fileSize = total.toDouble();
        //       downloadedSize = sent.toDouble();
        //     });
        //   },
        // );

        if (!mounted) return;
        setState(() {});
        await Future.delayed(const Duration(milliseconds: 400));
      } catch (e) {
        debugPrint(e.toString());
      }
    }

    if (!mounted) return;
    Navigator.pop(context);
    widget.onSuccess();
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      scrollable: true,
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text('$uploadIndex/${widget.pathList.length}'),
            Text(progressMsg),
            LinearProgressIndicator(
              value: fileSize == 0 ? null : downloadedSize / fileSize,
            ),
            //label
            fileSize == 0
                ? const SizedBox.shrink()
                : Text(
                    '${downloadedSize.toDouble().toFileSizeLabel()} / ${fileSize.toDouble().toFileSizeLabel()}',
                  ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _downloadCancel();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }

  void _downloadCancel() {
    try {
      // cancelToken.cancel();
      Navigator.pop(context);
    } catch (e) {
      errorMsg += '${e.toString()}\n';
    }
  }
}
