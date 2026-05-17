import 'package:flutter/material.dart';

class TListTileWithDesc extends StatelessWidget {
  String title;
  String desc;
  Widget? trailing;
  Widget? leading;
  double spacing;
  bool isUseCardWidget;
  EdgeInsetsGeometry padding;
  void Function()? onClick;
  TListTileWithDesc({
    super.key,
    required this.title,
    this.trailing,
    this.desc = '',
    this.leading,
    this.spacing = 10,
    this.onClick,
    this.isUseCardWidget = true,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick?.call(),
      child: MouseRegion(
        cursor: onClick != null ? SystemMouseCursors.click : MouseCursor.defer,
        child: isUseCardWidget ? Card(child: _getWidget()) : _getWidget(),
      ),
    );
  }

  Widget _getWidget() {
    return Padding(
      padding: padding,
      child: Row(
        spacing: spacing,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _getLeading(),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, overflow: TextOverflow.ellipsis),
                desc.isEmpty ? const SizedBox(height: 5) : SizedBox.shrink(),
                desc.isEmpty
                    ? SizedBox.shrink()
                    : Text(
                      desc,
                      style: const TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
              ],
            ),
          ),
          _getTrailing(),
        ],
      ),
    );
  }

  Widget _getLeading() {
    if (leading == null) {
      return SizedBox.shrink();
    }
    return leading!;
  }

  Widget _getTrailing() {
    if (trailing == null) {
      return SizedBox.shrink();
    }
    return trailing!;
  }
}
