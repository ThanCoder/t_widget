import 'dart:async';

import 'package:t_widgets/src/progress_manager/progress_message.dart';

abstract class ProgressManagerInterface {
  void cancel();
  Future<void> start(StreamController<ProgressMessage> controller);

  Stream<ProgressMessage> run() {
    final controller = StreamController<ProgressMessage>.broadcast();
    start(controller);
    return controller.stream;
  }
}
