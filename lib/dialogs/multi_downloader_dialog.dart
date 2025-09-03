import 'package:flutter/material.dart';
import 'package:t_widgets/extensions/double_extension.dart';

class MultiDownloaderDialog extends StatefulWidget {
  List<String> downloadUrlList;
  void Function(String errorMsg) onClosed;

  MultiDownloaderDialog({
    super.key,
    required this.downloadUrlList,
    required this.onClosed,
  });

  @override
  State<MultiDownloaderDialog> createState() => _MultiDownloaderDialogState();
}

class _MultiDownloaderDialogState extends State<MultiDownloaderDialog> {
  @override
  void initState() {
    downloadLength = widget.downloadUrlList.length;
    super.initState();
    init();
  }

  // final dio = Dio();
  // final CancelToken cancelToken = CancelToken();
  double fileSize = 0;
  double downloadedSize = 0;
  String progressMsg = 'Preparing...';
  String errorMsg = '';
  int downloadIndex = 0;
  int downloadLength = 0;

  void init() async {
    // final dir = Directory('');
    // final name = 'name';

    // for (var url in widget.downloadUrlList) {
      // progressMsg = 'Downloading : $name';
      // downloadIndex++;
      // final savedPath = '${dir.path}/$name';
      // final file = File(savedPath);
      // if (await file.exists()) continue;
      // if (!mounted) return;
      // setState(() {});
      // await dio.download(
      //   Uri.encodeFull(url),
      //   savedPath,
      //   cancelToken: cancelToken,
      //   onReceiveProgress: (count, total) {
      //     setState(() {
      //       fileSize = total.toDouble();
      //       downloadedSize = count.toDouble();
      //     });
      //   },
      // );
    // }
    // await Future.delayed(const Duration(milliseconds: 400));

    // if (!mounted) return;
    // Navigator.pop(context);
    // widget.onClosed(errorMsg);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('All Download'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text('$downloadIndex/$downloadLength'),
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
    Navigator.pop(context);
    try {} catch (e) {
      errorMsg += '${e.toString()}\n';
    }
  }
}
