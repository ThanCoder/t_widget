import 'dart:async';
import 'dart:io';

Future<void> downloadImageDefaultFun(
  String url,
  String savePath, {
  required HttpClient client,
  void Function(String error)? onError,
  required void Function(double progress) onProgress,
  required void Function(
    StreamSubscription<List<int>> subscription,
    HttpClientRequest request,
  )
  onDownloadStart,
  void Function()? onDownloaded,
}) async {
  final temFile = File('$savePath.tmp');
  final completer = Completer<void>();

  try {
    final request = await client.getUrl(Uri.parse(url));
    final response = await request.close();

    if (response.statusCode == HttpStatus.ok) {
      // စုစုပေါင်း ပုံရဲ့ Size (Header ကနေ ယူတာပါ)
      final total = response.contentLength;
      int received = 0;

      final sink = temFile.openWrite();
      // Response ကို stream အဖြစ် နားထောင်ပြီး Progress တွက်မယ်
      final sub = response.listen(
        (List<int> chunk) async {
          // await Future.delayed(Duration(milliseconds: 900));

          received += chunk.length;
          sink.add(chunk); // File ထဲ ထည့်မယ်

          if (total != -1) {
            // final progress = (received / total * 100).toStringAsFixed(0);
            // print('Download Progress: $progress%');
            onProgress(received / total);
          }
        },
        onDone: () async {
          await sink.close();
          if (temFile.existsSync()) {
            await temFile.rename(savePath);
          }
          // print('Download complete and saved to $savePath');
          onDownloaded?.call();
          completer.complete();
        },
        onError: (e) {
          // print('Error during download: $e');
          sink.close();
          onError?.call('Error during download: $e');
          completer.completeError(e);
        },
        cancelOnError: true,
      );
      onDownloadStart(sub, request);
    } else {
      // print('Server Error: ${response.statusCode}');
      onError?.call('Server Error: ${response.statusCode}');
      completer.completeError('Server Error');
    }
  } catch (e) {
    onError?.call('Connection Error: $e');
    completer.completeError(e);
  }
  return completer.future;

  // try {
  //   // ၁။ Request ပို့ပါ
  //   final request = await client.getUrl(Uri.parse(url));

  //   // ၂။ Response ကို စောင့်ပါ
  //   final response = await request.close();

  //   // ၃။ Status Code ကို စစ်ပါ (၂၀၀ ဆိုရင် အိုကေ)
  //   if (response.statusCode == HttpStatus.ok) {
  //     // Response stream ကို file ထဲကို တိုက်ရိုက် pipe လုပ်ပါ (Memory အစားသက်သာဆုံးနည်း)
  //     await response.pipe(file.openWrite());

  //     // print('Download complete: $savePath');
  //     onDownloaded?.call();
  //   } else {
  //     if (file.existsSync()) {
  //       file.delete();
  //     }
  //     onError?.call('Download failed: ${response.statusCode}');
  //     // print('Download failed: ${response.statusCode}');
  //   }
  // } catch (e) {
  //   if (file.existsSync()) {
  //     file.delete();
  //   }
  //   onError?.call('Error: $e');
  //   // print('Error: $e');
  // } finally {
  //   // ၄။ Client ကို အမြဲတမ်း ပြန်ပိတ်ပေးဖို့ လိုပါတယ်
  //   client.close();
  // }
}
