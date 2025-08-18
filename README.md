# TWidget 1.0.0

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
  // onOpenImageFileChooser:({initialDirectory})async {
  //   await Future.delayed(Duration(seconds: 2));
  //   return null;
  // },
);

// app services
await TAppServices.clearAndRefreshImage();
await TAppServices.copyText('text');
final text = await TAppServices.pasteFromClipboard();

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
