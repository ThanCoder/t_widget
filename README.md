# t_widgets

```Dart
await TWidgets.instance.init(
  // required for TImage,TCoverImage -> default cover path
  defaultImageAssetsPath: 'assets/logo.webp',
  isDebugPrint: true,
  getDarkMode: () => darkNotifier.value,
  onDownloadImage: (url, savePath) async {
    //your logic here
    //await Dio().download(url, savePath);
    //for download image
    await Future.delayed(Duration(seconds: 2));
  },
);

// app services
await TAppServices.clearAndRefreshImage();
await TAppServices.copyText('text');
final text = await TAppServices.pasteFromClipboard();

```
