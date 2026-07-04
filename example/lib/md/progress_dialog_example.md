# Progress Dialog Example

```dart
void main() {
  showProgressDialog(
     context: context,
     barrierDismissible: false,
     progressManager: ProgressManger(),
  );
}
```

## Need To Implement
```dart
class ProgressManger extends ProgressManagerInterface {
  bool isCanceld = false;
  @override
  void cancel() {
    isCanceld = true;
  }

  @override
  Future<void> start(StreamController<ProgressMessage> controller) async {
    controller.add(ProgressMessage.preparing());
    for (var i = 1; i <= 100; i++) {
      if (isCanceld) break;
      controller.add(
        ProgressMessage.progress(
          index: i,
          indexLength: 100,
          progress: i / 100,
          message: 'Progress: $i',
        ),
      );
      await Future.delayed(Duration(milliseconds: 200));
    }
    controller.add(ProgressMessage.done());
    controller.close();
  }
}
```
