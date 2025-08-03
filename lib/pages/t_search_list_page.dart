// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../t_widgets.dart';

class TSearchListPage extends StatefulWidget {
  Widget? title;
  List<String> values;
  List<String> list;
  String cancelText;
  String submitText;
  void Function(List<String> values) onSubmit;
  void Function()? onCancel;
  Widget? renameLabelText;
  void Function(String text)? onChanged;
  String? Function(String text)? onCheckIsError;
  bool autofocus;
  TSearchListPage({
    super.key,
    required this.list,
    required this.values,
    this.title,
    this.cancelText = 'Close',
    this.submitText = 'Apply',
    this.renameLabelText,
    required this.onSubmit,
    this.onCancel,
    this.onChanged,
    this.onCheckIsError,
    this.autofocus=false,
  });

  @override
  State<TSearchListPage> createState() => _TSearchListPageState();
}

class _TSearchListPageState extends State<TSearchListPage> {
  TextEditingController controller = TextEditingController();
  String? errorText;

  @override
  void initState() {
    controller.text = widget.values.join(',');
    // _checkError(controller.text);
    super.initState();
  }

  void _addOrRemoveSearchText(bool isChecked, String name) {
    var values = controller.text.split(',').where((e) => e.isNotEmpty).toList();
    if (isChecked) {
      values.add(name);
    } else {
      // ရှိနေရင် ဖျက်မယ်
      values = values.where((e) => e != name).toList();
    }
    controller.text = values.join(',');
    setState(() {});
  }

  List<String> get _getValues =>
      controller.text.split(',').where((e) => e.isNotEmpty).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: widget.title),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: TTextField(
                controller: controller,
                label: widget.renameLabelText,
                autofocus: widget.autofocus,
                errorText: errorText,
                onChanged: (value) {
                  // _checkError(value);
                  if (widget.onChanged != null) {
                    widget.onChanged!(value);
                  }
                },
                onSubmitted: (value) {
                  if (errorText == null) {
                    Navigator.pop(context);
                    widget.onSubmit(_getValues);
                  }
                },
              ),
            ),
            SliverList.separated(
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                final item = widget.list[index];
                return CheckboxListTile.adaptive(
                  value: _getValues.contains(item),
                  title: Text(item),
                  onChanged: (value) {
                    if (value == null) return;
                    _addOrRemoveSearchText(value, item);
                  },
                );
              },
              separatorBuilder: (context, index) => Divider(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
          widget.onSubmit(_getValues);
        },
        child: Icon(Icons.save_as_rounded),
      ),
    );
  }
}
