import 'package:flutter/cupertino.dart';
import 'package:gibas/core/app/color_palette.dart' show ColorPalette;
import 'package:gibas/core/app/constant/image_type.dart';
import 'package:gibas/domain/usecase/text_usecase.dart';
import 'package:gibas/shared/typography/typography_component.dart';

class WidgetUsecase {
  static Widget status(String? status) {
    Color color = ColorPalette.grey;
    switch (status?.toLowerCase()) {
      case Constant.statusPaid:
      case Constant.statusActive:
      case Constant.statusSuccess:
        color = ColorPalette.green;
        break;
      case Constant.statusPending:
      case Constant.statusProcess:
        color = ColorPalette.yellow;
        break;
      case Constant.statusDraft:
        color = ColorPalette.blueLight;
        break;
      case Constant.statusSubmited:
      case Constant.statusOnProcess:
        color = ColorPalette.secondary;
        break;
      case Constant.statusApproved:
      case Constant.statusDone:
        color = ColorPalette.primary;
        break;
      case Constant.statusReject:
      case Constant.statusUnPaid:
      case Constant.statusDeActive:
        color = ColorPalette.red;
        break;
      default:
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextComponent.textBody(
        status,
        colors: ColorPalette.white,
        type: TextBodyType.s1,
        textAlign: TextAlign.center,
      ),
    );
  }

  static Widget reason(String? value) {
    final Color color = ColorPalette.primary;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextComponent.textBody(
        value,
        colors: color,
        bold: true,
        textAlign: TextAlign.center,
        type: TextBodyType.s1,
      ),
    );
  }

  static Widget imageTypeName(String? value) {
    final ImageType imageType = ImageType.fromString(value) ?? ImageType.detailing;
    final Color color = ColorPalette.blue;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextComponent.textBody(
        TextUsecase.imageTypeName(imageType),
        colors: color,
        bold: true,
        textAlign: TextAlign.center,
        type: TextBodyType.s1,
      ),
    );
  }

  static Widget statusSend({bool? send = false}) {
    final Color color = send! ? ColorPalette.buttonColorRed : ColorPalette.primary;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withAlpha(50),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextComponent.textBody(
        send == true ? 'Belum Terkirim' : 'Terkirim',
        colors: color,
        bold: true,
        textAlign: TextAlign.center,
        type: TextBodyType.s1,
      ),
    );
  }
}
