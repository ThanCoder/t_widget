# t_widgets

```Dart
void main() async {
  await TWidgets.instance.init(
    defaultImageAssetsPath: 'assets/logo.webp',
    isDebugPrint: true,
    getDarkMode: () => darkNotifier.value,
  );
  runApp(MyApp());
}
```