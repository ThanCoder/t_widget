# Sort Provider

```dart
SortButton(
    value: .dateSortItem,
    list: [.nameSortItem, .dateSortItem, .sizeSortItem],
),
```

## With Dialog
```dart
 SortItem? item = await showModalBottomSheet<SortItem>(
    context: context,
    builder: (context) => SortProviderDialog(
    list: [.nameSortItem, .dateSortItem, .sizeSortItem],
    value: .nameSortItem,
    ),
);
print('SortItem: $item'); // SortItem: SortItem(id: 1000, title: Text("Name"), isTrue: true, trueTitle: Text("A To Z"), falseTitle: Text("Z To A"))
```

## Base Item
```dart
class SortItem {
  final int id;
  final Widget title;
  final bool isTrue;
  final Widget trueTitle;
  final Widget falseTitle;
  SortItem({
    required this.id,
    required this.title,
    required this.isTrue,
    required this.trueTitle,
    required this.falseTitle,
  });
}
```