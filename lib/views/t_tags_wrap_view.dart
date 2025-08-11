import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

class TTagsWrapView extends StatefulWidget {
  Widget? title;
  Color? backgroundColor;
  Color? textColor;
  List<String> values;
  List<String> allTags;
  TTagsTypes type;
  TSearchListTypes searchListType;
  void Function(List<String> values)? onApply;
  void Function()? onAddButtonClicked;
  void Function(String value)? onClicked;
  void Function(bool isChecked, String value)? onChecked;
  TTagsWrapView({
    super.key,
    this.title,
    required this.values,
    this.allTags = const [],
    this.type = TTagsTypes.chip,
    this.searchListType = TSearchListTypes.chipList,
    this.onApply,
    this.backgroundColor,
    this.textColor,
    this.onAddButtonClicked,
    this.onClicked,
    this.onChecked,
  });

  @override
  State<TTagsWrapView> createState() => _TTagsWrapViewState();
}

class _TTagsWrapViewState extends State<TTagsWrapView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        _getTitle(),
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

  // open page
  void _addTags() {
    if (widget.onAddButtonClicked != null) {
      widget.onAddButtonClicked!();
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => TSearchListPage(
              type: widget.searchListType,
              list: widget.allTags,
              values: widget.values,
              autofocus: true,
              cancelText: 'Close',
              submitText: 'New',
              onCheckIsError: (text) {
                if (widget.values.contains(text)) {
                  return 'Already Exists!';
                }
                return null;
              },
              onSubmit: (List<String> values) {
                if (widget.onApply == null) return;
                widget.onApply!(values);
              },
            ),
      ),
    );
  }

  // widget
  List<Widget> _getWidgetList() {
    return List.generate(widget.values.length, (index) {
      final name = widget.values[index];
      // text widget
      if (widget.type == TTagsTypes.text) {
        return _getTextTagWidget(index, name);
      }
      // chip widget
      return _getChipWidget(index, name);
    });
  }

  Widget _getTextTagWidget(int index, String name) {
    final isDark = TWidgets.instance.getDarkMode();

    return GestureDetector(
      onTap: () {
        if (widget.onClicked == null) return;
        widget.onClicked!(name);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.1),
            borderRadius: BorderRadius.circular(3),
          ),
          child: Wrap(
            spacing: 2,
            children: [
              Text(name),
              widget.onApply == null
                  ? SizedBox.shrink()
                  : widget.onApply == null
                  ? SizedBox.shrink()
                  : GestureDetector(
                    onTap: () {
                      widget.values.removeAt(index);
                      if (widget.onApply == null) return;
                      widget.onApply!(widget.values);
                    },
                    child: Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: const Color.fromARGB(255, 201, 34, 22),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getChipWidget(int index, String name) {
    return TChip(
      backgroundColor: widget.backgroundColor,
      title: Text(name, style: TextStyle(color: widget.textColor)),
      avatar:
          widget.onChecked != null && widget.allTags.contains(name)
              ? Icon(Icons.check)
              : null,
      onClick: () {
        if (widget.onChecked != null) {
          widget.onChecked!(false, name);
        }
      },
      onDelete:
          widget.onApply == null
              ? null
              : () {
                widget.values.removeAt(index);
                if (widget.onApply != null) {
                  widget.onApply!(widget.values);
                }
                if (widget.onChecked != null) {
                  widget.onChecked!(true, name);
                }
              },
    );
  }

  Widget _addButton() {
    if (widget.onAddButtonClicked == null && widget.onApply == null) {
      return SizedBox.shrink();
    }
    return IconButton(
      color: Colors.green,
      onPressed: _addTags,
      icon: const Icon(Icons.add_circle_outlined),
    );
  }

  Widget _getTitle() {
    if (widget.title != null) {
      return widget.title!;
    }
    return SizedBox.shrink();
  }
}
