import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionBottomSheet, Get, GetNavigation;
import 'package:image_picker/image_picker.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/constant/enum.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/shared/component/button_option_component.dart';
import 'package:gibas/shared/component/buttons.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/typography_component.dart';

class BottomsheetHelper {
  static Future<T?> regular<T>({
    required String title,
    required Widget content,
    bool isScrollControlled = false,
    bool isDismissible = true,
    double? maxHeight,
  }) {
    return Get.bottomSheet(
      Container(
        constraints: maxHeight == null
            ? null
            : BoxConstraints(
                maxHeight: Get.height * maxHeight,
              ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Dimens.marginVerticalMedium(),
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: ColorPalette.greyBorder,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Dimens.marginVerticalMedium(),
              Padding(
                padding: Dimens.marginContentHorizontal20,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: TextComponent.textTitle(title, bold: true),
                    ),
                    IconButton(
                      icon: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorPalette.white2,
                        ),
                        child: const Icon(
                          Icons.close,
                          size: Dimens.iconSizeSmall,
                          color: ColorPalette.blackText,
                        ),
                      ),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ),
              Dimens.marginVerticalMedium(),
              Flexible(child: content),
            ],
          ),
        ),
      ),
      shape: Component.bottomsheetShape(),
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      backgroundColor: ColorPalette.white,
    );
  }

  static Future<ActionType?> optionAction() async {
    return await regular(
      title: 'Aksi',
      content: Padding(
        padding: Dimens.marginContentHorizontal20.copyWith(bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ButtonOptionComponent(
              onClick: () => Get.back(result: ActionType.edit),
              text: 'Edit',
              iconData: Icons.edit,
              alignment: Alignment.centerLeft,
            ),
            Dimens.marginHorizontalMedium(),
            ButtonOptionComponent(
              onClick: () => Get.back(result: ActionType.delete),
              text: 'Hapus',
              iconData: Icons.delete,
              type: ButtonType.cancel,
              alignment: Alignment.centerLeft,
            ),
            Dimens.marginVerticalMedium(),
            ButtonOptionComponent(
              onClick: () => Get.back(),
              text: 'Batal',
            ),
          ],
        ),
      ),
    );
  }

  static Future<bool?> confirmDelete(String title, String message) async {
    return await regular(
      title: 'Konfirmasi Hapus',
      isScrollControlled: true,
      content: Padding(
        padding: Dimens.marginContentHorizontal20.copyWith(bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Dimens.marginVerticalXLarge(),
            TextComponent.textTitle(
              title,
              bold: true,
              textAlign: TextAlign.center,
            ),
            Dimens.marginVerticalMedium(),
            TextComponent.textBody(
              message,
              textAlign: TextAlign.center,
            ),
            Dimens.marginVerticalXLarge(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 40,
                      alignment: Alignment.center,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: ColorPalette.white2,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: ColorPalette.greyBorder,
                        ),
                      ),
                      child: TextComponent.textTitle(
                        'Batal',
                        bold: true,
                      ),
                    ),
                  ),
                ),
                Dimens.marginHorizontalMedium(),
                Expanded(
                  child: InkWell(
                    onTap: () => Get.back(result: true),
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: ColorPalette.buttonColorRed,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextComponent.textTitle(
                        'Hapus',
                        bold: true,
                        colors: ColorPalette.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Future<bool?> confim(String title, String message) async {
    return await regular(
      title: '',
      isScrollControlled: true,
      content: Padding(
        padding: Dimens.marginContentHorizontal20.copyWith(bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Dimens.marginVerticalLarge(),
            TextComponent.textTitle(
              title,
              bold: true,
              textAlign: TextAlign.center,
            ),
            Dimens.marginVerticalLarge(),
            TextComponent.textBody(
              message,
              textAlign: TextAlign.center,
            ),
            Dimens.marginVerticalXXLarge(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Buttons.outlineButton(
                    title: 'Batal',
                    onPressed: () => Get.back(result: false),
                    fitWidth: true,
                  ),
                ),
                Dimens.marginHorizontalMedium(),
                Expanded(
                  child: Buttons.primaryButton(
                    title: 'Ya',
                    onPressed: () => Get.back(result: true),
                    fitWidth: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Future<ImageSource?> optionImage() async {
    return await regular(
      title: 'Pilih photo',
      content: Padding(
        padding: Dimens.marginContentHorizontal20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => Get.back(result: ImageSource.camera),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.camera_alt,
                            color: ColorPalette.primary,
                          ),
                          Dimens.marginVerticalMedium(),
                          TextComponent.textBody(
                            'Ambil photo',
                            colors: ColorPalette.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Dimens.marginHorizontalMedium(),
                Expanded(
                  child: InkWell(
                    onTap: () => Get.back(result: ImageSource.gallery),
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorPalette.primary,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.image,
                            color: ColorPalette.white,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextComponent.textBody(
                            'Pilih dari Gallery',
                            colors: ColorPalette.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Dimens.marginVerticalXLarge(),
          ],
        ),
      ),
    );
  }

  static void gpsDisabled() {
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Dimens.marginVerticalXXLarge(),
            const Icon(
              CupertinoIcons.location_slash_fill,
              color: ColorPalette.primary,
              size: Dimens.imageSizeMedium,
            ),
            Dimens.marginVerticalXLarge(),
            TextComponent.textTitle('GPS Mati'),
            Dimens.marginVerticalMedium(),
            TextComponent.textBody(
              'Aplikasi tidak dapat menemukan lokasi anda, pastikan GPS pada handphone aktif harap cek kembali',
              maxLines: 4,
              textAlign: TextAlign.center,
            ),
            Dimens.marginVerticalMedium(),
            Buttons.close(),
            Dimens.marginVerticalLarge(),
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      isScrollControlled: true,
      backgroundColor: ColorPalette.white,
    );
  }

  static void gpsPermissionDenied() {
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Dimens.marginVerticalLarge(),
            const Icon(
              Icons.location_off,
              color: ColorPalette.primary,
              size: 70,
            ),
            Dimens.marginVerticalXLarge(),
            TextComponent.textBody('GPS'),
            Dimens.marginVerticalMedium(),
            TextComponent.textBody(
              'Tidak dapat mendapatkan lokasi GPS, pastikan izinkan aplikasi untuk mengakses lokasi anda',
              maxLines: 4,
              textAlign: TextAlign.center,
            ),
            Dimens.marginVerticalMedium(),
            TextComponent.textBody(
              'Anda bisa mengaktifkan GPS pada pengaturan anda',
              maxLines: 4,
              textAlign: TextAlign.center,
            ),
            Dimens.marginVerticalXLarge(),
            Buttons.close(),
            Dimens.marginVerticalLarge(),
          ],
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      isScrollControlled: true,
      backgroundColor: ColorPalette.white,
    );
  }

  static Future error({String? message}) {
    return Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Dimens.marginVerticalXLarge(),
            TextComponent.textTitle('Oops, terjadi kesalahan!', bold: true),
            Dimens.marginVerticalLarge(),
            TextComponent.textBody(
              message ?? 'Server sedang mengalami gangguan, harap coba beberapa saat lagi',
              maxLines: 4,
              textAlign: TextAlign.center,
            ),
            Dimens.marginVerticalXXLarge(),
            Buttons.close(),
            Dimens.marginVerticalLarge(),
          ],
        ),
      ),
      shape: Component.bottomsheetShape(),
      isScrollControlled: true,
      backgroundColor: Colors.white,
    );
  }
}
