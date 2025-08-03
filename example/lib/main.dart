import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';
import 'package:t_widgets/types/t_loader_types.dart';
import 'package:t_widgets/widgets/t_number_field.dart';

final darkNotifier = ValueNotifier<bool>(false);

void main() async {
  await TWidgets.instance.init(
    // required for TImage,TCoverImage -> default cover path
    defaultImageAssetsPath: 'assets/logo.webp',
    isDebugPrint: true,
    getDarkMode: () => darkNotifier.value,
    onDownloadImage: (url, savePath) async {
      //your logic here
      //await Dio().download(url, savePath);
      //for download image
      await Future.delayed(Duration(seconds: 2));
    },
  );
  // app services
  // await TAppServices.clearAndRefreshImage();
  // await TAppServices.copyText('text');
  // final text = await TAppServices.pasteFromClipboard();

  runApp(MyApp());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> values = ['name', 'age','name', 'age', 'place', 'home'];
  List<String> allTags = ['name', 'age', 'place', 'home'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TCoverChooser(
              coverPath:
                  '/home/than/Downloads/Telegram Desktop/photo_2025-07-16_01-40-55.jpg',
            ),
            TTextField(hintText: 'text'),
            TNumberField(hintText: 'number'),
            TChip(title: Text('hello')),
            TListTileWithDesc(title: 'hello', desc: 'i am desc'),
            TTagsWrapView(
              textColor: Colors.white,
              backgroundColor: Colors.teal,
              // title: Text('tags'),
              values: values,
              allTags: allTags,
              // onApply: (values) {
              //   this.values = values;
              //   setState(() {});
              // },
            ),
            TImageUrl(url: 'https://raw.githubusercontent.com/ThanCoder/novel-v3-static-server/refs/heads/main/server/images/b1a6805d-8f01-44fc-b241-c349625bf55c.png', size: 150),

            TLoader(types: TLoaderTypes.CubeGrid),
            TLoaderRandom(),
            TImageFile(path: '', size: 100),
            
            TCacheImage(url: '', size: 150),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // darkNotifier.value = !darkNotifier.value;
          // showTMessageDialog(context, 'hello',color: Colors.red);
          showTMessageDialogError(context, 'snapbar error');
        },
      ),
    );
  }
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
          home: HomeScreen(),
        );
      },
    );
  }
}
