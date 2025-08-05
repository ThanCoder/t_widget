import 'package:flutter/material.dart';

class TSeeAllView<T> extends StatelessWidget {
  List<T> list;
  String title;
  Color? titleColor;
  Widget moreTitle;
  int showCount;
  int? showLines;
  double fontSize;
  double padding;
  EdgeInsetsGeometry? margin;
  void Function(String title, List<T> list) onSeeAllClicked;
  Widget? Function(BuildContext context, T item) gridItemBuilder;

  TSeeAllView({
    super.key,
    required this.title,
    required this.list,
    required this.onSeeAllClicked,
    required this.gridItemBuilder,
    this.moreTitle = const Text('More', style: TextStyle(color: Colors.blue)),
    this.showCount = 5,
    this.margin,
    this.showLines = 1,
    this.fontSize = 11,
    this.padding = 6,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final showList = list.take(showCount).toList();
    if (showList.isEmpty) return const SizedBox.shrink();
    int showLine = 1;
    if (showLines == null && showList.length > 1) {
      showLine = 2;
    } else {
      showLine = showLines ?? 1;
    }

    return Container(
      padding: EdgeInsets.all(padding),
      margin: margin,
      child: SizedBox(
        height: showLine * 170,
        child: Column(
          spacing: 5,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(color: titleColor)),
                list.length > showCount
                    ? Container(
                      margin: const EdgeInsets.only(right: 5),
                      child: TextButton(
                        onPressed: () => onSeeAllClicked(title, list),
                        child: moreTitle,
                      ),
                    )
                    : const SizedBox.shrink(),
              ],
            ),
            Expanded(
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: showList.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 170,
                  mainAxisExtent: 130,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemBuilder:
                    (context, index) => gridItemBuilder(context, list[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
