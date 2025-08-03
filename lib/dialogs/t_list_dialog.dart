import 'package:flutter/material.dart';

class TListDialog<T> extends StatelessWidget {
  List<T> list;
  double? height;
  Widget? Function(BuildContext context, T item) listItemBuilder;
  Widget Function(BuildContext, int)? separatorBuilder;
  void Function() onSubmit;
  void Function() onClose;
  TListDialog({
    super.key,
    required this.list,
    required this.listItemBuilder,
    this.separatorBuilder,
    this.height = 200,
    required this.onClose,
    required this.onSubmit,
  });

  Widget _getDefaultSeparator(BuildContext context, int index) {
    if (separatorBuilder != null) {
      return separatorBuilder!(context, index);
    }
    return const Divider();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      content: SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ListView.separated(
          itemBuilder:
              (context, index) => listItemBuilder(context, list[index]),
          separatorBuilder: _getDefaultSeparator,
          itemCount: list.length,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onClose();
          },
          child: Text('Close'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onSubmit();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
