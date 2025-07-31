import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';

import '../t_widgets.dart';

class TCoverChooser extends StatefulWidget {
  String coverPath;
  VoidCallback? onChanged;
  TCoverChooser({super.key, required this.coverPath, this.onChanged});

  @override
  State<TCoverChooser> createState() => _TCoverChooserState();
}

class _TCoverChooserState extends State<TCoverChooser> {
  bool isLoading = false;
  late String imagePath;

  @override
  void initState() {
    imagePath = widget.coverPath;
    super.initState();
  }

  void _showMenu() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 150),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _addFromPath();
                    },
                    leading: const Icon(Icons.add),
                    title: const Text('Add From Path'),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _downloadUrl();
                    },
                    leading: const Icon(Icons.add),
                    title: const Text('Add From Url'),
                  ),
                  File(widget.coverPath).existsSync()
                      ? ListTile(
                        onTap: () {
                          Navigator.pop(context);
                          _delete();
                        },
                        iconColor: Colors.red,
                        leading: const Icon(Icons.delete_forever_rounded),
                        title: const Text('Delete'),
                      )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
    );
  }

  void _downloadUrl() {
    showDialog(
      context: context,
      builder:
          (context) => TRenameDialog(
            autofocus: true,
            renameLabelText: const Text('Download From Url'),
            submitText: 'Download',
            text: '',
            onCheckIsError: (text) {
              if(!text.startsWith('http')){
                return 'url required!';
              }
              return null;
            },
            onSubmit: (url) async {
              try {
                setState(() {
                  isLoading = true;
                });

                if (TWidgets.instance.onDownloadImage == null) {
                  throw Exception('''await TWidgets.instance.init(
          onDownloadImage: (url, savePath) async {
          //your logic here
          },
        );''');
                }
                // await Dio().download(url, widget.coverPath);
                await TWidgets.instance.onDownloadImage!(
                  url,
                  widget.coverPath,
                );

                if (!mounted) return;

                setState(() {
                  isLoading = false;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!();
                }
              } catch (e) {
                if (!mounted) return;
                setState(() {
                  isLoading = false;
                });
                TWidgets.instance.showDebugLog(e.toString());
              }
            },
          ),
    );
  }

  void _addFromPath() async {
    try {
      setState(() {
        isLoading = true;
      });
      final files = await openFiles(
        acceptedTypeGroups: [
          const XTypeGroup(
            mimeTypes: ['image/png', 'image/jpg', 'image/webp', 'image/jpeg'],
          ),
        ],
      );
      if (files.isNotEmpty) {
        final path = files.first.path;
        final file = File(path);
        if (widget.coverPath.isNotEmpty) {
          await file.copy(widget.coverPath);
          // clear image cache
          await TAppServices.clearAndRefreshImage();
        }
        imagePath = path;
      }
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      if (widget.onChanged != null) {
        widget.onChanged!();
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      TWidgets.instance.showDebugLog(e.toString());
    }
  }

  void _delete() async {
    try {
      setState(() {
        isLoading = true;
      });
      final file = File(widget.coverPath);
      if (await file.exists()) {
        await file.delete();
        await TAppServices.clearAndRefreshImage();

        await Future.delayed(const Duration(seconds: 1));

        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
        if (widget.onChanged != null) {
          widget.onChanged!();
        }
      }
    } catch (e) {
      TWidgets.instance.showDebugLog(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _showMenu,
        child: SizedBox(
          width: 150,
          height: 150,
          child:
              isLoading
                  ? TLoader()
                  : TImageFile(path: imagePath, borderRadius: 5),
        ),
      ),
    );
  }
}
