import 'dart:async';

import 'package:flutter/material.dart';
import 'package:t_widgets/progress_manager/progress_manager_interface.dart';
import 'package:t_widgets/progress_manager/progress_message.dart';

Future<T?> showProgressDialog<T>({
  required BuildContext context,
  required ProgressManagerInterface progressManager,
  bool barrierDismissible = false,
  Color? barrierColor,
  String? barrierLabel,
  bool useSafeArea = true,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
  TraversalEdgeBehavior? traversalEdgeBehavior,
  bool? requestFocus,
  AnimationStyle? animationStyle,
}) {
  return showAdaptiveDialog<T>(
    barrierDismissible: barrierDismissible,
    context: context,
    barrierColor: barrierColor,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    traversalEdgeBehavior: traversalEdgeBehavior,
    requestFocus: requestFocus,
    animationStyle: animationStyle,
    builder: (context) => ProgressDialog(progressManager: progressManager),
  );
}

class ProgressDialog extends StatefulWidget {
  final ProgressManagerInterface progressManager;
  const ProgressDialog({super.key, required this.progressManager});

  @override
  State<ProgressDialog> createState() => _ProgressDialogState();
}

class _ProgressDialogState extends State<ProgressDialog> {
  late StreamSubscription<ProgressMessage> progressSub;
  ProgressMessage? _progress;
  bool isDone = false;
  String? errorMsg;

  @override
  void initState() {
    progressSub = widget.progressManager.run().listen(
      (progress) {
        _progress = progress;
        if (!mounted) return;
        setState(() {});
      },
      onDone: () {
        setState(() {
          isDone = true;
          errorMsg = null;
        });
      },
      onError: (err) {
        setState(() {
          errorMsg = err.toString();
          isDone = true;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    progressSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      scrollable: true,
      content: _progress == null
          ? Text('Preparing...')
          : Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _progress!.indexLength == 0
                    ? SizedBox.shrink()
                    : Text(
                        '${_progress!.index}/${_progress!.indexLength}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                _getMessage(),
                LinearProgressIndicator(value: _progress!.progress),
              ],
            ),
      actions: _getActions(),
    );
  }

  Widget _getMessage() {
    if (errorMsg != null) {
      return Text('Error: $errorMsg', style: TextStyle(color: Colors.red));
    } else {
      return Text(_progress!.message);
    }
  }

  List<Widget> _getActions() {
    return [
      !isDone
          ? TextButton(
              onPressed: () {
                widget.progressManager.cancel();
              },
              child: Text('Cancel'),
            )
          : TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
    ];
  }
}
