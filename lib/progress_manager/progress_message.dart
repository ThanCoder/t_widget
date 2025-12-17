class ProgressMessage {
  final int index;
  final int indexLength;
  final double? progress;
  final String message;
  ProgressMessage({
    required this.index,
    required this.indexLength,
    required this.progress,
    required this.message,
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
    );
  }

  factory ProgressMessage.preparing({String message = 'Preparing'}) {
    return ProgressMessage(
      index: 0,
      indexLength: 0,
      progress: null,
      message: message,
    );
  }
  factory ProgressMessage.done({String message = 'Done'}) {
    return ProgressMessage(
      index: 0,
      indexLength: 0,
      progress: 1,
      message: message,
    );
  }

  ProgressMessage copyWith({
    int? index,
    int? indexLength,
    double? progress,
    String? message,
  }) {
    return ProgressMessage(
      index: index ?? this.index,
      indexLength: indexLength ?? this.indexLength,
      progress: progress ?? this.progress,
      message: message ?? this.message,
    );
  }
}
