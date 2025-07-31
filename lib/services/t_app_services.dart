import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TAppServices {
  static Future<void> clearAndRefreshImage({
    Duration delayTime = const Duration(milliseconds: 500),
  }) async {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    await Future.delayed(delayTime);
  }

  static Future<void> copyText(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
    } catch (e) {
      debugPrint('copyText: ${e.toString()}');
    }
  }

  static Future<String> pasteFromClipboard() async {
    String res = '';
    ClipboardData? data = await Clipboard.getData('text/plain');
    if (data != null) {
      res = data.text ?? '';
    }
    return res;
  }
}
