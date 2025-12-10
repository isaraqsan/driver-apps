import 'package:gibas/core/utils/log.dart';
import 'package:flutter/services.dart';

class NativeCompressor {
  static const MethodChannel _channel = MethodChannel('com.example.compress');

  static Future<String?> compressImage(String path) async {
    try {
      final result = await _channel.invokeMethod('compressImage', {'path': path});
      return result as String?;
    } on PlatformException catch (e) {
      Log.e('Error compressing image: ${e.message}', tag: NativeCompressor().runtimeType.toString());
      return null;
    }
  }
}
