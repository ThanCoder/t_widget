enum TProgressTypes { preparing, progress, done, error }

abstract class TManager {
  void cancel();
  Stream<TProgress> actions(List<String> sourceList);
}

abstract class TDownloadManager extends TManager {
  @override
  Stream<TProgress> actions(List<String> urls);
}

abstract class TUploadManager extends TManager {
  @override
  Stream<TProgress> actions(List<String> pathList);
}

class TProgress {
  final int index;
  final int indexLength;
  final int total;
  final int loaded;
  final TProgressTypes status; // preparing, downloading, done, error
  final String message;

  TProgress({
    required this.index,
    required this.indexLength,
    required this.total,
    required this.loaded,
    required this.status,
    required this.message,
  });
  factory TProgress.preparing({
    required int indexLength,
    int fileSize = 0,
    String message = '',
  }) {
    return TProgress(
      index: 0,
      indexLength: indexLength,
      total: 0,
      loaded: 0,
      status: TProgressTypes.preparing,
      message: message,
    );
  }
  factory TProgress.done({required String message}) {
    return TProgress(
      index: 0,
      indexLength: 0,
      total: 0,
      loaded: 0,
      status: TProgressTypes.done,
      message: message,
    );
  }

  factory TProgress.error({required String message}) {
    return TProgress(
      index: 0,
      indexLength: 0,
      total: 0,
      loaded: 0,
      status: TProgressTypes.error,
      message: message,
    );
  }
  factory TProgress.progress({
    required int index,
    required int indexLength,
    required int loaded,
    required int total,
    required String message,
  }) {
    return TProgress(
      index: index,
      loaded: loaded,
      total: total,
      indexLength: indexLength,
      status: TProgressTypes.progress,
      message: message,
    );
  }
}
