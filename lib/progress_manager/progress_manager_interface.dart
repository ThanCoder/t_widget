import 'dart:async';

import 'package:t_widgets/progress_manager/progress_message.dart';

abstract class ProgressManagerInterface {
  void cancel();
  Future<void> start(StreamController<ProgressMessage> streamController);

  Stream<ProgressMessage> run() {
    final controller = StreamController<ProgressMessage>.broadcast();
    start(controller);
    return controller.stream;
  }
}
