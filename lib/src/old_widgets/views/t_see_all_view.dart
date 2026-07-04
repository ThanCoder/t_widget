import 'package:flutter/material.dart';

typedef OnSeeAllClickedCallback<T> = void Function(String title, List<T> list);
typedef GridItemBuilderCallback<T> =
    Widget Function(BuildContext context, T item);

class TSeeAllView<T> extends StatelessWidget {
  final List<T> list;
  final String title;
  final String moreTitle;
  final int showCount;
  final double fontSize;
  final double padding;
  final EdgeInsetsGeometry? margin;
  final Color? titleColor;
  final OnSeeAllClickedCallback<T>? onSeeAllClicked;
  final GridItemBuilderCallback<T> gridItemBuilder;
  final double itemHeight;
  final double itemWidth;
  final double viewHeight;
  final bool showMoreButtonBottomPos;
  final int? showLines;
  final double itemSpacing;

  const TSeeAllView({
    super.key,
    required this.title,
    required this.list,
    this.onSeeAllClicked,
    required this.gridItemBuilder,
    this.showCount = 4,
    this.margin,
    this.fontSize = 11,
    this.padding = 6,
    this.moreTitle = 'More',
    this.titleColor,
    this.itemHeight = 200,
    this.viewHeight = 200,
    this.itemWidth = 160,
    this.showLines = 1,
    this.itemSpacing = 5,
    this.showMoreButtonBottomPos = false,
  });

  @override
  Widget build(BuildContext context) {
    final showList = list.take(showCount).toList();
    if (showList.isEmpty) {
      return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        // header row
        _getHeader(),
        // grid item
        SizedBox(
          height: viewHeight,
          width: MediaQuery.of(context).size.width,
          child: GridView.builder(
            itemCount: showList.length,
            scrollDirection: Axis.horizontal,
            gridDelegate: _getSliverGridDelegate(),
            itemBuilder: (context, index) => MouseRegion(
              cursor: SystemMouseCursors.click,
              child: gridItemBuilder(context, showList[index]),
            ),
          ),
        ),
        // botton nav
        _getSeeAllButtonBottomPos(),
      ],
    );
  }

  SliverGridDelegate _getSliverGridDelegate() {
    if (showLines != null) {
      return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisSpacing: itemSpacing,
        crossAxisSpacing: itemSpacing,
        mainAxisExtent: itemWidth,
      );
    }
    return SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: itemHeight,
      mainAxisExtent: itemWidth,
      mainAxisSpacing: itemSpacing,
      crossAxisSpacing: itemSpacing,
    );
  }

  Widget _getHeader() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: titleColor)),
          _getSeeAllButton(),
        ],
      ),
    );
  }

  Widget _getSeeAllButtonBottomPos() {
    if (!showMoreButtonBottomPos) {
      return const SizedBox.shrink();
    }
    if (list.length > showCount) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(height: 15),
          TextButton(
            onPressed: () => onSeeAllClicked?.call(title, list),
            child: Text('See All', style: TextStyle(color: Colors.blue)),
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }

  Widget _getSeeAllButton() {
    if (list.length > showCount) {
      return Container(
        margin: const EdgeInsets.only(right: 2),
        child: GestureDetector(
          onTap: () => onSeeAllClicked?.call(title, list),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Row(
              spacing: 2,
              children: [
                Text(moreTitle, style: const TextStyle(color: Colors.blue)),
                Icon(Icons.arrow_forward_ios, size: 15),
              ],
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
