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
showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => TMultiDownloaderDialog(
    manager: TDownloadManager(),
    urls: [
      'http://10.37.17.103:9000/download?path=/storage/emulated/0/Download/Telegram/Dandadan%20S02E09.mp4',
    ],
  ),
);

class DownloadManager extends TDownloadManager {
  final token = TClientToken(isCancelFileDelete: true);
  final client = TClient();
  final savePath = '/home/than/Downloads/personal_server';

  @override
  void cancel() {
    token.cancel();
  }

  @override
  Stream<TProgress> actions(List<String> urls) {
    final controller = StreamController<TProgress>();
    (() async {
      try {
        controller.add(TProgress.preparing(indexLength: urls.length));

        int index = 0;
        for (var url in urls) {
          final name = url.getName();

          index++;
          await client.download(
            url,
            token: token,
            savePath: '$savePath/$name',
            onError: controller.addError,
            // onReceiveProgress: (received, total) {
            //   controller.add(
            //     TProgress.progress(
            //       index: index,
            //       indexLength: urls.length,
            //       message: '$name\n Downloading...',
            //       loaded: received,
            //       total: total,
            //     ),
            //   );
            // },
            onReceiveProgressSpeed: (received, total, speed, eta) {
              controller.add(
                TProgress.progress(
                  index: index,
                  indexLength: urls.length,
                  message:
                      '$name\n Downloading...\n Speed: ${speed.toFileSizeLabel()} Left: ${eta?.toAutoTimeLabel()}',
                  loaded: received,
                  total: total,
                ),
              );
            },
          );
        }

        controller.add(TProgress.done(message: 'Downloaded'));
      } catch (e) {
        controller.addError(e);
      }
    })();
    return controller.stream;
  }
}

final path = '/home/than/Videos';
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => TMultiDownloaderDialog(
      manager: UploadManager(),
      pathList: ['$path/Dan Da Dan S02 E02.mp4'],
    ),
  );
class UploadManager extends TUploadManager {
  final token = TClientToken(isCancelFileDelete: true);
  final client = TClient();
  final String apiUrl = 'http://10.37.17.103:9000/upload';

  @override
  void cancel() {
    token.cancel();
  }

  @override
  Stream<TProgress> actions(List<String> pathList) {
    final controller = StreamController<TProgress>();
    (() async {
      try {
        controller.add(TProgress.preparing(indexLength: pathList.length));

        int index = 0;
        for (var path in pathList) {
          final name = path.getName();

          index++;
          await client.upload(
            apiUrl,
            file: File(path),
            token: token,
            onError: controller.addError,
            onCancelCallback: controller.addError,
            onUploadProgress: (sent, total) {
              controller.add(
                TProgress.progress(
                  index: index,
                  indexLength: pathList.length,
                  message: '$name\n Uploading...',
                  loaded: sent,
                  total: total,
                ),
              );
            },
          );
        }

        controller.add(TProgress.done(message: 'Uploaded'));
      } catch (e) {
        controller.addError(e);
      }
    })();
    return controller.stream;
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
