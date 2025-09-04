abstract class TDownloadManager {
  Stream<DownloadProgress> downloadFiles(List<String> urls);
  void cancel();
}

class DownloadProgress {
  final int index;
  final int total;
  final double downloaded;
  final double fileSize;
  final String status; // preparing, downloading, done, error

  DownloadProgress({
    required this.index,
    required this.total,
    required this.downloaded,
    required this.fileSize,
    required this.status,
  });
}


