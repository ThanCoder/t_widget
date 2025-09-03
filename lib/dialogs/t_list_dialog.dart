import 'package:flutter/material.dart';

typedef ItemListBuilderCallback<T> =
    Widget Function(BuildContext context, T item);
typedef SeparatorBuilderCallback<T> =
    Widget Function(BuildContext context, T item);

class TListDialog<T> extends StatelessWidget {
  final List<T> list;
  final ItemListBuilderCallback<T> listItemBuilder;
  final SeparatorBuilderCallback? separatorBuilder;
  final VoidCallback? onSubmit;
  final VoidCallback? onClose;
  final double? height;
  final Widget? closeText;
  final Widget? submitText;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? title;
  final double maxWidth;
  const TListDialog({
    super.key,
    required this.list,
    required this.listItemBuilder,
    this.contentPadding,
    this.separatorBuilder,
    this.height = 200,
    this.title,
    this.onClose,
    this.onSubmit,
    this.closeText,
    this.submitText,
    this.maxWidth = 400,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: title,
      contentPadding: contentPadding,
      content: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: SizedBox(
          height: height,
          width: MediaQuery.of(context).size.width * 0.9,
          child: ListView.separated(
            itemBuilder: (context, index) =>
                listItemBuilder(context, list[index]),
            separatorBuilder: _getDefaultSeparator,
            itemCount: list.length,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onClose?.call();
          },
          child: closeText ?? Text('Close'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onSubmit?.call();
          },
          child: submitText ?? Text('Submit'),
        ),
      ],
    );
  }

  Widget _getDefaultSeparator(BuildContext context, int index) {
    if (separatorBuilder != null) {
      return separatorBuilder!(context, index);
    }
    return const Divider();
  }
}
