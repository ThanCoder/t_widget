import 'package:flutter/material.dart';

class TScaffold extends StatelessWidget {
  Widget body;
  Widget? floatingActionButton;
  AppBar? appBar;
  Widget? drawer;
  Widget? endDrawer;
  Widget? bottomSheet;
  Color? backgroundColor;
  TScaffold({
    super.key,
    required this.body,
    this.floatingActionButton,
    this.appBar,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      endDrawer: endDrawer,
      body: body,
      floatingActionButton: floatingActionButton,
      bottomSheet: bottomSheet,
      backgroundColor: backgroundColor,
    );
  }
}
