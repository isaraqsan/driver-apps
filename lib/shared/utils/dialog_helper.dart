import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, ExtensionDialog, GetNavigation;
import 'package:gibas/core/app/theme.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/typography_component.dart';

class DialogHelper {
  static Future<bool?> confirm({String? title, String? message}) {
    return Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Dimens.marginVerticalLarge(),
              TextComponent.textTitle(title ?? 'Konfirmasi',
                  textAlign: TextAlign.center,
                  bold: true,
                  type: TextTitleType.xl1),
              Dimens.marginVerticalLarge(),
              TextComponent.textTitle(
                message ?? 'Apakah kamu yakin?',
                textAlign: TextAlign.center,
              ),
              Dimens.marginVerticalXLarge(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => Get.back(result: false),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        decoration: Component.shadow(color: ColorPalette.red),
                        child: TextComponent.textBody('Tidak',
                            colors: ColorPalette.white),
                      ),
                    ),
                  ),
                  Dimens.marginHorizontalLarge(),
                  Expanded(
                    child: InkWell(
                      onTap: () => Get.back(result: true),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        decoration:
                            Component.shadow(color: ColorPalette.primary),
                        child: TextComponent.textBody('Ya',
                            colors: ColorPalette.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ).then((value) => value ?? false);
  }

  static Future<void> info({String? title, String? message}) {
    return Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Dimens.marginVerticalLarge(),
              TextComponent.textTitle(
                title ?? 'Info',
                textAlign: TextAlign.center,
                bold: true,
                type: TextTitleType.xl1,
              ),
              Dimens.marginVerticalLarge(),
              TextComponent.textTitle(
                message ?? '',
                textAlign: TextAlign.center,
              ),
              Dimens.marginVerticalXLarge(),
              InkWell(
                onTap: () => Get.back(),
                child: Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: Component.shadow(color: ColorPalette.primary),
                  child:
                      TextComponent.textBody('OK', colors: ColorPalette.white),
                ),
              ),
              Dimens.marginVerticalLarge(),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
