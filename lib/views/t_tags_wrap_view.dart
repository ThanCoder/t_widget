import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

class TTagsWrapView extends StatefulWidget {
  String title;
  List<String> values;
  List<String> allTags;
  void Function(List<String> values)? onApply;
  TTagsWrapView({
    super.key,
    required this.title,
    required this.values,
    this.allTags = const [],
    this.onApply,
  });

  @override
  State<TTagsWrapView> createState() => _TTagsWrapViewState();
}

class _TTagsWrapViewState extends State<TTagsWrapView> {
  List<Widget> _getWidgetList() {
    return List.generate(widget.values.length, (index) {
      final name = widget.values[index];
      return TChip(
        title: Text(name),
        onDelete: () {
          widget.values.removeAt(index);
          if(widget.onApply == null) return;
          widget.onApply!(widget.values);
        },
      );
    });
  }

  void _addTags() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => TSearchListPage(
              list: widget.allTags.map((e) => e).toList(),
              values: widget.values,
              cancelText: 'Close',
              submitText: 'New',
              onCheckIsError: (text) {
                if (widget.values.contains(text)) {
                  return 'Already Exists!';
                }
                return null;
              }, onSubmit: (List<String> values) { 
                if(widget.onApply == null) return;
                widget.onApply!(values);
               },
            ),
      ),
    );
  }

  Widget _addButton() {
    return IconButton(
      color: Colors.green,
      onPressed: _addTags,
      icon: const Icon(Icons.add_circle_outlined),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Text(widget.title),
        Wrap(
          spacing: 5,
          runSpacing: 5,
          alignment: WrapAlignment.start,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [..._getWidgetList(), _addButton()],
        ),
      ],
    );
  }
}
