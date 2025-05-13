import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:t_widgets/types/t_loader_types.dart';

final darkNotifier = ValueNotifier<bool>(false);

void main() async {
  await TWidgets.instance.init(
    defaultImageAssetsPath: 'assets/logo.webp',
    isDebugPrint: true,
    getDarkMode: () => darkNotifier.value,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: darkNotifier,
      builder: (context, value, child) {
        return MaterialApp(
          darkTheme: ThemeData.dark(),
          themeMode: value ? ThemeMode.dark : null,
          home: Home(),
        );
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return TScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TTextField(),
            TChip(title: Text('hello')),
            TListTileWithDesc(title: 'hello', desc: 'i am desc'),
            TLoader(types: TLoaderTypes.CubeGrid),
            TImageFile(path: '', size: 100),
            TImageUrl(url: '', size: 50),
            TCacheImage(url: '', size: 150),
            // Wrap(
            //   spacing: 5,
            //   runSpacing: 5,
            //   children: TLoaderTypes.getWidgetList(),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // darkNotifier.value = !darkNotifier.value;
          showCupertinoDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => AlertDialog(content: Text('hello')),
          );
        },
      ),
    );
  }
}
