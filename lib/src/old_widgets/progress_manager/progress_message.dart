enum ProgressMessageType { preparing, progress, error, done }

class ProgressMessage {
  final int index;
  final int indexLength;
  final double? progress;
  final String message;
  final ProgressMessageType type;
  ProgressMessage({
    required this.index,
    required this.indexLength,
    required this.progress,
    required this.message,
    required this.type,
  });

  factory ProgressMessage.progress({
    required int index,
    required int indexLength,
    required double? progress,
    required String message,
  }) {
    return ProgressMessage(
      index: index,
      indexLength: indexLength,
      progress: progress,
      message: message,
      type: ProgressMessageType.progress,
    );
  }

  factory ProgressMessage.preparing({String message = 'Preparing'}) {
    return ProgressMessage(
      index: 0,
      indexLength: 0,
      progress: null,
      message: message,
      type: ProgressMessageType.preparing,
    );
  }
  factory ProgressMessage.done({String message = 'Done'}) {
    return ProgressMessage(
      index: 0,
      indexLength: 0,
      progress: 1,
      message: message,
      type: ProgressMessageType.done,
    );
  }
  factory ProgressMessage.error({String message = 'Error'}) {
    return ProgressMessage(
      index: 0,
      indexLength: 0,
      progress: 1,
      message: message,
      type: ProgressMessageType.error,
    );
  }
}
