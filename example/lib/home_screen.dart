import 'package:flutter/material.dart';
import 'package:t_widgets/types/t_loader_types.dart';
import 'package:t_widgets/widgets/t_number_field.dart';
import 'package:t_widgets/t_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> values = ['name', 'age'];
  List<String> allTags = ['name', 'age', 'place', 'home'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TTextField(hintText: 'text'),
            TNumberField(hintText: 'number'),
            TChip(title: Text('hello')),
            TListTileWithDesc(title: 'hello', desc: 'i am desc'),
            TTagsWrapView(
              title: 'tags',
              values: values,
              allTags: allTags,
              onApply: (values) {
                this.values = values;
                setState(() {});
              },
            ),

            TLoader(types: TLoaderTypes.CubeGrid),
            TLoaderRandom(),
            TImageFile(path: '', size: 100),
            TImageUrl(url: '', size: 50),
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
