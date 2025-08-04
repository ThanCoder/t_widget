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
  TSearchListTypes type;
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
    this.autofocus = false,
    this.type = TSearchListTypes.checkList,
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: widget.title),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              snap: true,
              pinned: true,
              expandedHeight: 100,
              flexibleSpace: TTextField(
                controller: controller,
                label: widget.renameLabelText,
                autofocus: widget.autofocus,
                errorText: errorText,
                maxLines: null,
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
            // style list
            _getSliverStyleList(),
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

  Widget _getSliverStyleList() {
    // chip list
    if (widget.type == TSearchListTypes.chipList) {
      return _getSliverChipWidget();
    }
    // list
    return _getSliverListWidget();
  }

  Widget _getSliverListWidget() {
    return SliverList.separated(
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
    );
  }

  Widget _getSliverChipWidget() {
    return SliverToBoxAdapter(
      child: Wrap(
        spacing: 5,
        runSpacing: 5,
        children: List.generate(widget.list.length, (index) {
          final item = widget.list[index];
          final isChecked = _getValues.contains(item);
          return TChip(
            title: Text(item),
            avatar: isChecked ? Icon(Icons.check) : null,
            onClick: () {
              _addOrRemoveSearchText(!isChecked, item);
            },
          );
        }),
      ),
    );
  }

  List<String> get _getValues =>
      controller.text.split(',').where((e) => e.isNotEmpty).toList();
}
