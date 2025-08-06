import 'package:flutter/material.dart';
import 'package:t_widgets/t_widgets.dart';

final darkNotifier = ValueNotifier<bool>(true);

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
    // onOpenImageFileChooser:({initialDirectory})async {
    //   await Future.delayed(Duration(seconds: 2));
    //   return null;
    // },
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
  List<String> values = [
    'name',
    'age',
    'name',
    'place',
    'city',
    'yangon',
    'mm',
    'gold',
    'mon',
    'fast',
    'logan',
  ];
  List<String> allTags = ['than', 'coder', 'win', 'mon'];

  List<String> get _getAllTags {
    allTags.addAll(values);
    return allTags.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TImage(source: 'https://raw.githubusercontent.com/ThanCoder/novel-v3-static-server/refs/heads/main/server/images/b1a6805d-8f01-44fc-b241-c349625bf55c.png',size: 200,),
            // TSeeAllView(title: title, list: list, onSeeAllClicked: onSeeAllClicked, gridItemBuilder: gridItemBuilder),
            // TCoverChooser(
            //   coverPath:
            //       '/home/than/Downloads/Telegram Desktop/photo_2025-07-16_01-40-55.jpg',
            // ),
            // TTextField(hintText: 'text'),
            // TNumberField(hintText: 'number'),
            // TChip(title: Text('hello')),
            TListTileWithDesc(title: 'hello', desc: 'i am desc'),
            TTagsWrapView(
              // textColor: Colors.white,
              // backgroundColor: Colors.teal,
              // title: Text('tags'),
              values: values,
              type: TTagsTypes.text,
              // searchListType: TSearchListTypes.checkList,
              allTags: _getAllTags,
              onApply: (values) {
                this.values = values;
                setState(() {});
              },
              // onAddButtonClicked: () {
              //   print('on add clicked');
              // },
            ),
            // TImageUrl(
            //   url:
            //       'https://raw.githubusercontent.com/ThanCoder/novel-v3-static-server/refs/heads/main/server/images/b1a6805d-8f01-44fc-b241-c349625bf55c.png',
            //   size: 150,
            // ),

            // TLoader(types: TLoaderTypes.CubeGrid),
            // TLoaderRandom(),
            // TImageFile(path: '', size: 100),

            // TCacheImage(url: '', size: 150),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // darkNotifier.value = !darkNotifier.value;
          

          // showTMessageDialog(context, 'hello',color: Colors.red);
          // showTMessageDialogError(context, 'snapbar error');
          // showTConfirmDialog(context, contentText: 'content', onSubmit: () {},barrierDismissible: false);
          // showTReanmeDialog(
          //   context,
          //   text: 'Untitled',
          //   onSubmit: (text) {},
          //   title: Text('title'),
          //   labelText: Text('label'),
          //   hintText: 'hint',
          //   barrierDismissible: false,
          // );
          // showTModalBottomSheet(
          //   context,
          //   child: Column(
          //     children: [
          //       ListTile(
          //         title: Text('one'),
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          //     ],
          //   ),
          // );
          // showTListDialog<String>(
          //   context,
          //   list: values,
          //   listItemBuilder:
          //       (context, item) => ListTile(
          //         title: Text(item),
          //         onTap: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          // );
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
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(),
          themeMode: value ? ThemeMode.dark : null,
          home: HomeScreen(),
        );
      },
    );
  }
}
