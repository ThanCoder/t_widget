import 'dart:async';
import 'package:flutter/material.dart';
import 'package:t_widgets/internal.dart';
import 'package:t_widgets/t_widgets_dev.dart';

class TMultiDownloaderDialog extends StatefulWidget {
  final List<String> urls;
  final TManager manager;
  final void Function(String message)? onError;
  final VoidCallback? onSuccess;
  final Widget? title;
  const TMultiDownloaderDialog({
    super.key,
    required this.manager,
    required this.urls,
    this.onError,
    this.onSuccess,
    this.title = const Text('Downloader'),
  });

  @override
  State<TMultiDownloaderDialog> createState() => _TMultiDownloaderDialogState();
}

class _TMultiDownloaderDialogState extends State<TMultiDownloaderDialog> {
  late final StreamSubscription<TProgress> _streamSub;
  TProgress? progress;
  String? errorMsg;
  bool isProgress = true;

  @override
  void initState() {
    _streamSub = widget.manager
        .actions(widget.urls)
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
          _getMessage(),
          // progress
          _getProgress(),
        ],
      ),
      actions: _getActions(),
    );
  }

  Widget _getMessage() {
    if (progress == null) {
      return SizedBox.shrink();
    }
    if (errorMsg != null) {
      return Text(errorMsg!, style: TextStyle(color: Colors.red));
    }
    return Text(progress!.message);
  }

  Widget _getProgress() {
    if (progress == null || errorMsg != null) {
      return SizedBox.shrink();
    }
    if (progress!.status == TProgressTypes.done) {
      return SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // progress lable
        Text('${progress!.index}/${progress!.indexLength}'),
        // progress
        LinearProgressIndicator(
          value: progress!.total == 0
              ? null
              : progress!.loaded / progress!.total,
        ),
        // label
        progress!.total == 0
            ? const SizedBox.shrink()
            : Text(
                '${progress!.loaded.toDouble().toFileSizeLabel()} / ${progress!.total.toDouble().toFileSizeLabel()}',
              ),
      ],
    );
  }

  List<Widget> _getActions() {
    return [
      isProgress
          ? TextButton(
              onPressed: () {
                widget.manager.cancel();
              },
              child: const Text('Cancel'),
            )
          : TextButton(
              onPressed: () {
                if (!mounted) return;
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
    ];
  }

  void _closeDialog() {
    isProgress = false;
    if (errorMsg == null) {
      widget.onSuccess?.call();
      if (!mounted) return;
      Navigator.pop(context);
    }
    if (!mounted) return;
    setState(() {});
  }
}
