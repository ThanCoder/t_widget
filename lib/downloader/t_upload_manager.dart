abstract class TUploadManager {
  Stream<UploadProgress> uploadFiles(List<String> pathList);
  void cancel();
}

class UploadProgress {
  final int index;
  final int total;
  final double uploaded;
  final double fileSize;
  final String status; // preparing, downloading, done, error

  UploadProgress({
    required this.index,
    required this.total,
    required this.uploaded,
    required this.fileSize,
    required this.status,
  });
}
