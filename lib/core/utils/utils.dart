import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart' show Icon;
import 'package:get/get.dart' show Get, ExtensionSnackbar;
import 'package:gibas/core/app/color_palette.dart' show ColorPalette;
import 'package:gibas/core/app/dimens.dart';

enum SnackType { success, info, error, warning }

class Utils {
  static Uint8List getImageBinary(dynamic dynamicList) {
    final List<int> intList = dynamicList.cast<int>().toList(); //This is the magical line.
    final Uint8List data = Uint8List.fromList(intList);
    return data;
  }

  static String numberFormatter(dynamic value) {
    final f = NumberFormat.compact(locale: 'id_ID');
    return f.format(value);
  }

  static String timeNow() => DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  static Future<bool> checkConnectivity() async {
    bool connect = false;
    try {
      final result = await InternetAddress.lookup('google.com').timeout(const Duration(seconds: 5));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connect = true;
      }
    } on SocketException catch (_) {
      connect = false;
    }
    return connect;
  }

  static String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
  }

  static Future<void> launchWhatsapp(String noWhatsapp) async {
    final whatsappAndroid = Uri.parse('whatsapp://send?phone=$noWhatsapp&text=Hallo Admin');
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      toast('Tidak dapat membuka url');
    }
  }

  static void toast(String? message, {SnackType snackType = SnackType.success}) {
    var backGroudColor = ColorPalette.green;
    var icon = const Icon(Icons.check);
    switch (snackType) {
      case SnackType.success:
        backGroudColor = ColorPalette.green;
        icon = const Icon(
          Icons.check,
          color: ColorPalette.white,
        );
        break;
      case SnackType.info:
        backGroudColor = ColorPalette.blueLight;
        icon = const Icon(
          Icons.info,
          color: ColorPalette.white,
        );
      case SnackType.warning:
        backGroudColor = ColorPalette.yellow;
        icon = const Icon(
          Icons.warning,
          color: ColorPalette.white,
        );
      case SnackType.error:
        backGroudColor = ColorPalette.red;
        icon = const Icon(
          Icons.close,
          color: ColorPalette.white,
        );
    }
    Get.rawSnackbar(
      message: message ?? '',
      backgroundColor: backGroudColor,
      icon: icon,
      duration: const Duration(seconds: 2),
      margin: Dimens.paddingToast,
      padding: Dimens.paddingToast.copyWith(top: 12, bottom: 12, left: 16, right: 16),
      borderRadius: 12,
    );
  }

  static Future<String?> convertToBase64(XFile file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  static String fileSize(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
    final i = (math.log(bytes) / math.log(1024)).floor();
    return '${(bytes / math.pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}';
  }
}
