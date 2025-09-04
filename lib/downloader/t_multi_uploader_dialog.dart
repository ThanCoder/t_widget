import 'dart:async';

import 'package:flutter/material.dart';
import 'package:t_widgets/downloader/t_upload_manager.dart';
import 'package:t_widgets/extensions/double_extension.dart';
import 'package:t_widgets/widgets/t_scrollable_column.dart';

class TMultiUploaderDialog extends StatefulWidget {
  final List<String> pathList;
  final TUploadManager manager;
  final VoidCallback? onSuccess;
  final Widget? title;

  const TMultiUploaderDialog({
    super.key,
    required this.pathList,
    required this.manager,
    this.onSuccess,
    this.title = const Text('Uploader'),
  });

  @override
  State<TMultiUploaderDialog> createState() => _TMultiUploaderDialogState();
}

class _TMultiUploaderDialogState extends State<TMultiUploaderDialog> {
  late final StreamSubscription<UploadProgress> _streamSub;
  UploadProgress? progress;
  String? errorMsg;

  @override
  void initState() {
    _streamSub = widget.manager
        .uploadFiles(widget.pathList)
        .listen(
          (event) {
            if (!mounted) return;
            progress = event;
            setState(() {});
          },
          onDone: _closeDialog,
          onError: (e) {
            if (!mounted) return;
            errorMsg = e.toString();
            _closeDialog();
          },
        );
    super.initState();
  }

  @override
  void dispose() {
    _streamSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      content: TScrollableColumn(
        children: [
          errorMsg == null
              ? SizedBox.shrink()
              : Text(errorMsg!, style: TextStyle(color: Colors.red)),
          errorMsg != null
              ? SizedBox.shrink()
              : Text(progress == null ? 'Preparing...' : progress!.status),
          // progress
          progress == null
              ? SizedBox.shrink()
              : errorMsg != null
              ? SizedBox.shrink()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // progress lable
                    Text('${progress!.index}/${progress!.total}'),
                    // progress
                    LinearProgressIndicator(
                      value: progress!.fileSize == 0
                          ? null
                          : progress!.uploaded / progress!.fileSize,
                    ),
                    // label
                    progress!.fileSize == 0
                        ? const SizedBox.shrink()
                        : Text(
                            '${progress!.uploaded.toDouble().toFileSizeLabel()} / ${progress!.fileSize.toDouble().toFileSizeLabel()}',
                          ),
                  ],
                ),
        ],
      ),
      actions: [
        errorMsg != null
            ? SizedBox.shrink()
            : TextButton(
                onPressed: () {
                  widget.manager.cancel();
                },
                child: const Text('Cancel'),
              ),
        errorMsg == null
            ? SizedBox.shrink()
            : TextButton(
                onPressed: () {
                  if (!mounted) return;
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
      ],
    );
  }

  void _closeDialog() {
    if (errorMsg == null) {
      widget.onSuccess?.call();
      if (!mounted) return;
      Navigator.pop(context);
    } else {
      // error
      if (!mounted) return;
      setState(() {});
    }
  }
}
