import 'package:flutter/material.dart';

class TListTileWithDescWidget extends StatelessWidget {
  Widget widget1;
  Widget widget2;
  String? desc;
  double spacing;
  TListTileWithDescWidget({
    super.key,
    required this.widget1,
    required this.widget2,
    this.spacing = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget1,
                  desc != null ? const SizedBox(height: 5) : SizedBox.shrink(),
                  desc != null
                      ? Text(
                          desc ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            widget2,
          ],
        ),
      ),
    );
  }
}
