import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

void main() async {
  await TWidgets.instance.init(defaultImageAssetsPath: 'assets/cover.png');
  runApp(MaterialApp(home: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin example app')),
      body: Center(child: TImage(source: '')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
      ),
    );
  }
}

