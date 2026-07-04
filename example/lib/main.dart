// ignore_for_file: avoid_print, unused_local_variable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

final appDarkThemeNotifier = ValueNotifier<bool>(false);

void main() async {
  final cacheDir = Directory('.cache');
  if (!cacheDir.existsSync()) {
    await cacheDir.create();
  }
  final name = 'thancoder';

  await TWidgets.instance.init(
    initialThemeServices: true,
    defaultImageAssetsPath: 'assets/thancoder_logo_1.png',
    getCachePath: (url, cacheName) => '${cacheDir.path}/$cacheName',
    isDarkTheme: () => appDarkThemeNotifier.value,
  );
  runApp(MaterialApp(home: Scaffold(body: const MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //https://help.imgur.com/hc/article_attachments/26512175039515?utm_source=chatgpt.com
  @override
  Widget build(BuildContext context) {
    return MaterialThemeProvider(
      value: .system,
      onChanged: (value) {
        print('changed: $value');
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Column(
          children: [
            MaterialThemeProviderChooser(),
            SortButton(
              value: .dateSortItem,
              list: [.nameSortItem, .dateSortItem, .sizeSortItem],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            SortItem? item = await showModalBottomSheet<SortItem>(
              context: context,
              builder: (context) => SortProviderDialog(
                list: [.nameSortItem, .dateSortItem, .sizeSortItem],
                value: .nameSortItem,
              ),
            );
            print('SortItem: $item');
          },
        ),
      ),
    );
  }
}
