import 'package:flutter/material.dart';

class TSearchField extends StatefulWidget {
  void Function(String text)? onChanged;
  void Function(String text)? onSubmitted;
  void Function()? onCleared;
  String hintText;
  bool autofocus;
  TSearchField({
    super.key,
    this.onChanged,
    this.onSubmitted,
    this.onCleared,
    this.hintText = 'Search...',
    this.autofocus = true,
  });

  @override
  State<TSearchField> createState() => _TSearchFieldState();
}

class _TSearchFieldState extends State<TSearchField> {
  final controller = TextEditingController();
  final focus = FocusNode();
  bool showClearBtn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focus,
      autofocus: widget.autofocus,
      onChanged: _onChanged,
      onSubmitted: widget.onSubmitted,
      maxLines: 1,
      decoration: _getDeco(),
    );
  }

  InputDecoration _getDeco() {
    return InputDecoration(
      hintText: widget.hintText,
      prefixIcon: const Icon(Icons.search),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      suffixIcon:
          showClearBtn
              ? IconButton(
                onPressed: () {
                  controller.text = '';
                  showClearBtn = false;
                  focus.unfocus();
                  setState(() {});
                  if (widget.onCleared != null) {
                    widget.onCleared!();
                  }
                },
                icon: const Icon(Icons.clear_all_rounded),
              )
              : null,
    );
  }

  void _onChanged(String text) {
    if (widget.onChanged != null) {
      widget.onChanged!(text);
    }
    //text ရှိိနေရင်
    if (text.isNotEmpty && !showClearBtn) {
      setState(() {
        showClearBtn = true;
      });
      return;
    }
    //text ရှိိနေရင်
    if (text.isEmpty && showClearBtn) {
      setState(() {
        showClearBtn = false;
      });
    }
  }
}
