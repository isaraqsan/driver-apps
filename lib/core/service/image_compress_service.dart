import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class ImageCompressService {
  /// Compress image supaya tidak lebih dari [maxSizeInMB]
  /// default 1.5 MB
  static Future<File?> compressImage(
    File file, {
    double maxSizeInMB = 1.5,
    int initialQuality = 85,
    int minWidth = 1080,
    int minHeight = 1080,
  }) async {
    try {
      final tempDir = await getTemporaryDirectory();
      String targetPath = path.join(
        tempDir.path,
        '${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}',
      );

      // compress dan hasilnya XFile?
      XFile? compressedXFile = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: initialQuality,
        keepExif: true,
        minWidth: minWidth,
        minHeight: minHeight,
      );

      if (compressedXFile == null) return null;

      File compressedFile = File(compressedXFile.path);

      int maxSizeInBytes = (maxSizeInMB * 1024 * 1024).toInt();
      int currentQuality = initialQuality;

      while (
          compressedFile.lengthSync() > maxSizeInBytes && currentQuality > 10) {
        currentQuality -= 5;

        targetPath = path.join(
          tempDir.path,
          '${DateTime.now().millisecondsSinceEpoch}_${path.basename(file.path)}',
        );

        compressedXFile = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path,
          targetPath,
          quality: currentQuality,
          keepExif: true,
          minWidth: minWidth,
          minHeight: minHeight,
        );

        if (compressedXFile == null) break;

        compressedFile = File(compressedXFile.path);
      }

      return compressedFile;
    } catch (e) {
      print('ImageCompressService error: $e');
      return null;
    }
  }
}
