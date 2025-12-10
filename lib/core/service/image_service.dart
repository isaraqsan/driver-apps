import 'dart:convert';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image/image.dart' as img;
import 'package:gibas/core/app/constant/image_type.dart';
import 'package:gibas/core/service/location_service.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gibas/shared/utils/bottomsheet_helper.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  static const String tag = 'ImageService';

  static Future<File?> image({
    ImageSource source = ImageSource.camera,
    CameraDevice cameraDevice = CameraDevice.rear,
    bool markAddress = false,
    ImageType? imageType,
  }) async {
    final picked = await ImagePicker().pickImage(
      source: source,
      imageQuality: 70,
      maxHeight: 1280,
      maxWidth: 768,
      preferredCameraDevice: cameraDevice,
    );

    if (picked != null) {
      return await compressFile(picked, markAddress: markAddress, imageType: imageType);
    }
    return null;
  }

  static Future<File?> imageWithOption({bool crop = false}) async {
    final source = await BottomsheetHelper.optionImage();
    if (source != null) {
      final picked = await ImagePicker().pickImage(source: source, imageQuality: 70);
      if (picked != null) {
        return await compressFile(picked, markAddress: crop);
      }
    }
    return null;
  }

  static Future<File?> compressFile(
    XFile file, {
    bool markAddress = false,
    ImageType? imageType,
  }) async {
    File? resultFile;

    Log.v('Compress Image => Size Before: ${Utils.fileSize(await file.length())}', tag: tag);
    if (markAddress) {
      resultFile = await compressAndAddLocation(File(file.path), imageType: imageType);
      if (resultFile != null) {
        Log.v('Compress Image => Size After: ${Utils.fileSize(await resultFile.length())}', tag: tag);
      }
    } else {
      resultFile = File(file.path);
    }

    return resultFile;
  }

  String convertImageToBase64(File imageUpload) {
    final imageBytes = imageUpload.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  static Future<File?> compressAndAddLocation(
    File file, {
    ImageType? imageType,
  }) async {
    try {
      final position = await LocationService().determinePosition(isLoading: true, cache: true);
      if (position == null) return null;

      String address = '';
      try {
        final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        if (placemarks.isNotEmpty) {
          final p = placemarks.first;
          address = '${p.street ?? ''}, ${p.subLocality ?? ''}, ${p.locality ?? ''}';
        }
      } catch (error) {
        Log.e(error.toString(), tag: tag);
        return null;
      }

      // Baca dan decode image asli
      final originalBytes = await file.readAsBytes();
      final image = img.decodeImage(originalBytes);
      if (image == null) {
        Log.e('Failed to decode image', tag: tag);
        return null;
      }

      // Bungkus alamat panjang ke beberapa baris
      final wrappedLines = _wrapText(address, maxWidth: image.width - 40);

      // Tambahkan setiap baris ke gambar
      const int lineHeight = 16; // tinggi font kira-kira
      final int baseY = image.height - 20 - (wrappedLines.length * lineHeight);

      for (var i = 0; i < wrappedLines.length; i++) {
        img.drawString(
          image,
          wrappedLines[i],
          font: img.arial14,
          x: 20,
          y: baseY + i * lineHeight,
          color: img.ColorRgb8(255, 255, 255),
        );
      }

      // Simpan hasil ke temporary file
      final tempDir = await getTemporaryDirectory();
      final tempFilePath = '${tempDir.path}/img_with_text_${DateTime.now().microsecondsSinceEpoch}.jpg';
      final tempFile = File(tempFilePath)..writeAsBytesSync(img.encodeJpg(image));

      // Kompres hasilnya
      final compressedPath = '${tempDir.path}/img_compressed_${DateTime.now().microsecondsSinceEpoch}.jpg';
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        tempFile.path,
        compressedPath,
      );

      // Hapus file temp yang tidak terpakai
      await tempFile.delete();

      if (compressedFile == null) {
        Log.e('Gagal kompres file', tag: tag);
        return null;
      }

      return File(compressedFile.path);
    } catch (e) {
      Log.e(e.toString(), tag: tag);
      return null;
    }
  }

  /// Fungsi untuk wrap teks agar tidak melewati batas gambar
  static List<String> _wrapText(String text, {required int maxWidth}) {
    const int charWidth = 8; // estimasi lebar per karakter (untuk font arial14)
    final maxChars = (maxWidth / charWidth).floor();

    final List<String> lines = [];
    String currentLine = '';

    for (final word in text.split(' ')) {
      if ((currentLine + word).length > maxChars) {
        lines.add(currentLine.trim());
        currentLine = '$word ';
      } else {
        currentLine += '$word ';
      }
    }
    if (currentLine.isNotEmpty) {
      lines.add(currentLine.trim());
    }

    return lines;
  }
}
