import 'package:flutter/material.dart';
import 't_sort_extension.dart';
import 't_show_sort_types.dart';
import 't_sort.dart';

typedef TSortDialogCallback = void Function(int id, bool isAsc);

class TSortDalog extends StatefulWidget {
  TSortDialogCallback sortDialogCallback;
  int? defaultId;
  bool isAsc;
  List<TSort>? sortList;
  Color activeColor;
  Color? activeTextColor;
  Widget? sortTitle;
  TShowSortTypes? showSortType;
  Widget? cancelText;
  Widget? submitText;
  TSortDalog({
    super.key,
    required this.sortDialogCallback,
    required this.defaultId,
    this.isAsc = true,
    this.sortList = const [],
    this.sortTitle,
    this.activeColor = Colors.teal,
    this.activeTextColor,
    this.showSortType = TShowSortTypes.id,
    this.cancelText,
    this.submitText,
  });

  @override
  State<TSortDalog> createState() => _TSortDalogState();
}

class _TSortDalogState extends State<TSortDalog> {
  List<TSort> list = [];
  bool isAsc = true;
  int currentId = 101;
  @override
  void initState() {
    isAsc = widget.isAsc;
    if (widget.sortList != null && widget.sortList!.isNotEmpty) {
      list = widget.sortList!;
      currentId = widget.defaultId ?? list.first.id;
    } else {
      list = TSort.getDefaultList;
      currentId = widget.defaultId ?? TSort.getDefaultList.last.id;
    }
    super.initState();
    init();
  }

  void init() {
    _showSortList();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      // contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      scrollable: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 5,
        children: [
          widget.sortTitle ??
              const Text(
                "Sort",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
          _getListWidget(),
          SizedBox(height: 10),
          _getAscWidget(),
        ],
      ),
      actions: _getActionWidget(),
    );
  }

  Widget _getListWidget() {
    return Wrap(
      children: List.generate(list.length, (index) {
        final sort = list[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              currentId = sort.id;
            });
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Card(
              color: sort.id == currentId ? widget.activeColor : null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  sort.title,
                  style: TextStyle(
                    color: sort.id == currentId ? widget.activeTextColor : null,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _getAscWidget() {
    final index = list.indexWhere((e) => e.id == currentId);
    if (index == -1) {
      return Text(
        'Sort ID:`$currentId` Not Found!',
        style: TextStyle(color: Colors.red),
      );
    }

    final sort = list[index];

    return Row(
      spacing: 5,
      children: [
        Expanded(
          child: _getTextButton(
            sort.ascTitle,
            isSelected: isAsc,
            onPressed: () {
              setState(() {
                isAsc = true;
              });
            },
          ),
        ),
        Expanded(
          child: _getTextButton(
            sort.descTitle,
            isSelected: !isAsc,
            onPressed: () {
              setState(() {
                isAsc = false;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _getTextButton(
    String text, {
    bool isSelected = false,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: () => onPressed?.call(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? widget.activeColor : const Color(0xFF000000),
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: isSelected ? widget.activeColor : null),
          ),
        ),
      ),
    );
  }

  List<Widget> _getActionWidget() {
    return [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: widget.cancelText ?? Text('Cancel'),
      ),
      TextButton(
        style: TextButton.styleFrom(iconColor: Colors.teal),
        onPressed: () {
          Navigator.pop(context);
          widget.sortDialogCallback(currentId, isAsc);
        },
        child: widget.submitText ?? Text('Submit'),
      ),
    ];
  }

  void _showSortList() {
    if (widget.showSortType == TShowSortTypes.id) {
      list.sortId();
    } else if (widget.showSortType == TShowSortTypes.title) {
      list.sortTitle();
    }

    setState(() {});
  }
}
