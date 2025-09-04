# TWidget 1.2.0

```Dart
await TWidgets.instance.init(
  // required for TImage,TCoverImage -> default cover path
  defaultImageAssetsPath: 'assets/logo.webp',
  isDebugPrint: true,
  getDarkMode: () => true,
  onDownloadImage: (url, savePath) async {
    //your logic here
    await Dio().download(url, savePath);
  },
  onOpenImageFileChooser:({initialDirectory})async {
    //your file chooser
    return null;
  },
);

// app services
await TAppServices.clearAndRefreshImage();
await TAppServices.copyText('text');
final text = await TAppServices.pasteFromClipboard();

```

## Multi Uploader && Downloader

```Dart
// multi uploader
final hostUrl = 'http://10.37.17.103:9000/upload?path=';
showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => TMultiUploaderDialog(
    pathList: ['/home/than/Videos/The.Sandman.2025.S02E06.mp4'],
    manager: DioUploadManager(hostUrl: hostUrl),
  ),
);
final urls = [
  'http://10.37.17.103:9000/download?path=/storage/emulated/0/Download/personal_server/Cadmium%20-%20Melody%20(ft.%20Jon%20Becker)%20(Lyrics%20Video).webm',
  'http://10.37.17.103:9000/download?path=/storage/emulated/0/Download/personal_server/Demons%20imagine%20dragons.mp4',
];
// multi downloader
showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => TMultiDownloaderDialog(
    manager: DioDownloadManager(savedDir: '/home/than'),
    urls: urls,
    onError: (message) {
      debugPrint(message);
    },
    onSuccess: () {
      debugPrint('success');
    },
  ),
);
//class
class DioUploadManager extends TUploadManager {
  final dio = Dio();
  final cancelToken = CancelToken();
  final String hostUrl;
  final Duration sendTimeout;
  final Duration receiveTimeout;
  DioUploadManager({
    required this.hostUrl,
    this.sendTimeout = const Duration(hours: 1),
    this.receiveTimeout = const Duration(hours: 1),
  });

  @override
  void cancel() {
    cancelToken.cancel('Cancel Upload');
  }

  @override
  Stream<UploadProgress> uploadFiles(List<String> pathList) {
    final controller = StreamController<UploadProgress>();
    int index = 0;

    () async {
      try {
        controller.add(
          UploadProgress(
            index: index,
            total: pathList.length,
            uploaded: 0,
            fileSize: 0,
            status: 'Preparing',
          ),
        );
        for (var path in pathList) {
          index++;
          final name = path.getName();
          final formData = FormData.fromMap({
            'file': await MultipartFile.fromFile(path, filename: name),
          });
          await dio.post(
            hostUrl,
            data: formData,
            cancelToken: cancelToken,
            options: Options(
              contentType: 'multipart/form-data',
              sendTimeout: sendTimeout, // 2GB ဆိုတာကြောင့် timeout ကြီးကြီးထား
              receiveTimeout: receiveTimeout,
            ),
            onSendProgress: (sent, total) {
              controller.add(
                UploadProgress(
                  index: index,
                  total: pathList.length,
                  uploaded: sent.toDouble(),
                  fileSize: total.toDouble(),
                  status: '$name Uploading...',
                ),
              );
            },
          );
        }
        // done
        controller.add(
          UploadProgress(
            index: index,
            total: pathList.length,
            uploaded: 0,
            fileSize: 0,
            status: 'Uploaded',
          ),
        );
      } catch (e) {
        controller.addError(e);
      } finally {
        await controller.close();
      }
    }();

    return controller.stream;
  }
}

class DioDownloadManager extends TDownloadManager {
  final dio = Dio();
  final cancelToken = CancelToken();
  final String savedDir;
  int index = 0;
  DioDownloadManager({required this.savedDir});

  @override
  void cancel() {
    cancelToken.cancel('Download Cancel');
  }

  @override
  Stream<DownloadProgress> downloadFiles(List<String> urls) {
    final streamController = StreamController<DownloadProgress>();

    () async {
      try {
        streamController.add(
          DownloadProgress(
            index: index,
            total: urls.length,
            downloaded: 0,
            fileSize: 0,
            status: 'Preparing...',
          ),
        );

        for (var url in urls) {
          index++;
          final name = url.getName();
          final savePath = '$savedDir/$name';

          await dio.download(
            url,
            savePath,
            cancelToken: cancelToken,
            onReceiveProgress: (count, total) {
              // Stream yield for UI update
              streamController.add(
                DownloadProgress(
                  index: index,
                  total: urls.length,
                  downloaded: count.toDouble(),
                  fileSize: total.toDouble(),
                  status: "`$name` Downloading...",
                ),
              );
            },
          );
        }
        streamController.add(
          DownloadProgress(
            index: index,
            total: urls.length,
            downloaded: 0,
            fileSize: 0,
            status: 'All Downloaded',
          ),
        );
      } catch (e) {
        streamController.addError(e);
      } finally {
        await streamController.close();
      }
    }();
    return streamController.stream;
  }
}

```

## Custom Widgets

```Dart
TCacheImage
TChip
TFontListWiget
TImageFile
TImageUrl
TImage
TListTileWithDescWidget
TListTileWithDesc
TLoaderRandom
TLoader
TNumberField
TScaffold
TScrollableColumn
TSearchField
TTextField
```

## Custom Chooser

```Dart
TCoverChooser
```

## Custom Dialogs

```Dart
TConfirmDialog
TListDialog<T>
TMessageDialog
TRenameDialog
TSortDalog
TAlertDialog
```

## Custom Views

```Dart
TSeeAllView<T>
TTagsWrapView
```

## Custom Functions

```Dart
getDefaultImageChooser

//dialog function
showTConfirmDialog
showTReanmeDialog
//show menu bottom sheet
showTModalBottomSheet
showTMenuBottomSheet
//dynamic list
showTListDialog<T>
// show message function
showTMessageDialog
showTMessageDialogError
showTSnackBar
showTSnackBarError
//Sorting widget
showTSortDialog

showTAlertDialog
```

## Custom Extensions

```Dart
DoubleExtension
FileSystemEntityExtension
StringExtension
TPlatform
TextEditingControllerExtension
```
