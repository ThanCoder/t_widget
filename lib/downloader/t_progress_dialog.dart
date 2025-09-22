import 'dart:async';

import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

class TProgressDialog extends StatefulWidget {
  final TProgressManager manager;
  final void Function(String message)? onError;
  final Widget? title;
  final VoidCallback? onSuccess;
  const TProgressDialog({
    super.key,
    required this.manager,
    this.title,
    this.onError,
    this.onSuccess,
  });

  @override
  State<TProgressDialog> createState() => _TProgressDialogState();
}

class _TProgressDialogState extends State<TProgressDialog> {
  late final StreamSubscription<TProgress> _streamSub;
  TProgress? progress;
  String? errorMsg;
  bool isProgress = true;

  @override
  void initState() {
    _streamSub = widget.manager.run().listen(
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
              ? progress == null
                    ? Text('Preparing...')
                    : _getMessage()
              : Text(errorMsg!, style: TextStyle(color: Colors.red)),
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
        progress!.status == TProgressTypes.preparing
            ? Text(progress!.status.name)
            : Text('${progress!.index}/${progress!.indexLength}'),
        // progress
        LinearProgressIndicator(
          value: progress!.total == 0
              ? null
              : progress!.loaded / progress!.total,
        ),
        // label
        progress!.total == 0
            ? const SizedBox.shrink()
            : Text('${progress!.loaded} / ${progress!.total}'),
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
