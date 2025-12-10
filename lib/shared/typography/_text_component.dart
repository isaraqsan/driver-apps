import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/dimens.dart' show Dimens;
import 'package:gibas/core/app/extensions/string.dart';
import 'package:gibas/shared/typography/typhography.dart';
import 'package:flutter/widgets.dart';

enum TextTitleType { m1, m2, m3, l1, l2, lwhite, l3, xl1, xl2, xl3, xxl1, xxl2, xxl3, xxxl1, xxxl2, xxxl3 }

enum TextBodyType { xs1, xs2, xs3, s19, s1, s2, s3, m1, m2, m3, l1, l2, l3 }

class TextComponent {
  static TextStyle textStyle() => ComponentTyphography.bodyMedium()!.copyWith(color: ColorPalette.blackText);

  static TextStyle textFieldInputStyle() => ComponentTyphography.bodyMedium()!.copyWith(color: ColorPalette.textBlack);

  static Widget twoPartTextRow({
    required String? leftText,
    required String? rightText,
    TextBodyType labelType = TextBodyType.l1,
    TextBodyType rightType = TextBodyType.l1,
    bool marginVertical = true,
    bool leftBold = false,
    bool rightBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: marginVertical ? 4 : 0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextComponent.textBody(
              leftText,
              type: labelType,
              bold: leftBold,
            ),
          ),
          Dimens.marginHorizontalMedium(),
          Expanded(
            child: TextComponent.textBody(
              rightText,
              type: rightType,
              bold: rightBold,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  static Widget textProductDetail({
    String? name,
    dynamic price,
    dynamic qty,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextComponent.textBody(
          name,
          bold: true,
          type: TextBodyType.s1,
        ),
        Dimens.marginHorizontalMedium(),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextComponent.textBody(
                '${price.toString().formatCurrency()} x ${qty.toString()}',
                textAlign: TextAlign.end,
                type: TextBodyType.s1,
              ),
              Dimens.marginVerticalSmall(),
              // TextComponent.textBody(
              //   Utils.moneyFormatter(
              //     DataUsecase.timesNumber(price, qty),
              //   ),
              //   bold: true,
              //   textAlign: TextAlign.end,
              //   type: TextBodyType.s1,
              // ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget textTitle(
    String? text, {
    Color? colors = ColorPalette.blackText,
    TextAlign? textAlign = TextAlign.start,
    TextTitleType type = TextTitleType.m1,
    bool bold = false,
    int? maxLines = 2,
  }) {
    var style = ComponentTyphography.titleSmall()!.copyWith(
      color: colors,
    );
    switch (type) {
      case TextTitleType.m1:
        style = ComponentTyphography.titleSmall()!.copyWith(
          color: colors,
        );
        break;
      case TextTitleType.m2:
        style = ComponentTyphography.titleSmall()!.copyWith(
          color: ColorPalette.primary,
        );
      case TextTitleType.m3:
        style = ComponentTyphography.titleSmall()!.copyWith(
          color: ColorPalette.white,
        );
        break;
      case TextTitleType.l1:
        style = ComponentTyphography.titleMedium()!.copyWith(
          color: colors,
        );
        break;
      case TextTitleType.l2:
        style = ComponentTyphography.titleMedium()!.copyWith(
          color: ColorPalette.textTitle,
        );
      case TextTitleType.l3:
        style = ComponentTyphography.titleMedium()!.copyWith(
          color: ColorPalette.white,
        );
      case TextTitleType.xl1:
        style = ComponentTyphography.titleLarge()!.copyWith(
          color: ColorPalette.blackText,
        );
        break;
      case TextTitleType.xl2:
        style = ComponentTyphography.titleLarge()!.copyWith(
          color: ColorPalette.primary,
        );
        break;
      case TextTitleType.xl3:
        style = ComponentTyphography.titleLarge()!.copyWith(
          color: ColorPalette.white,
          fontWeight: FontWeight.bold,
        );
        break;
      case TextTitleType.xxl1:
        style = ComponentTyphography.headlineSmall()!.copyWith(
          color: ColorPalette.blackText,
        );
        break;
      case TextTitleType.xxxl1:
        style = ComponentTyphography.headlineSmall()!.copyWith(
          color: ColorPalette.blackText,
        );
        break;
      case TextTitleType.xxxl3:
        style = ComponentTyphography.headlineSmall()!.copyWith(
          color: ColorPalette.white,
        );
        break;
      default:
        break;
    }
    if (bold) {
      style = style.copyWith(fontWeight: FontWeight.bold);
    } else {
      style = style.copyWith(fontWeight: FontWeight.normal);
    }
    return Text(
      text ?? '',
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }

  static Text textBody(
    String? text, {
    Color? colors,
    TextAlign? textAlign = TextAlign.start,
    TextBodyType type = TextBodyType.m1,
    bool bold = false,
    int? maxLines,
  }) {
    var style = ComponentTyphography.bodySmall()!.copyWith(
      color: ColorPalette.blackText,
    );
    switch (type) {
      case TextBodyType.xs1:
        style = ComponentTyphography.bodyMini().copyWith(
          color: ColorPalette.textGrey,
        );
      case TextBodyType.xs2:
        style = ComponentTyphography.bodyMini().copyWith(
          color: ColorPalette.white,
        );
      case TextBodyType.xs3:
        style = ComponentTyphography.bodyMini().copyWith(
          color: ColorPalette.blackText,
        );
      case TextBodyType.s1:
        style = ComponentTyphography.bodyExtraSmall().copyWith(
          color: ColorPalette.blackText,
        );
      case TextBodyType.s2:
        style = ComponentTyphography.bodyExtraSmall().copyWith(
          color: ColorPalette.primary,
        );
      case TextBodyType.s3:
        style = ComponentTyphography.bodyExtraSmall().copyWith(
          color: ColorPalette.white,
        );
      case TextBodyType.s19:
        style = ComponentTyphography.bodyExtraSmall10().copyWith(
          color: ColorPalette.blackText,
        );
      case TextBodyType.m1:
        style = ComponentTyphography.bodySmall()!.copyWith(
          color: colors,
        );
        break;
      case TextBodyType.m2:
        style = ComponentTyphography.bodySmall()!.copyWith(
          color: ColorPalette.primary,
          fontWeight: FontWeight.bold,
        );
        break;
      case TextBodyType.m3:
        style = ComponentTyphography.bodySmall()!.copyWith(
          color: ColorPalette.white,
        );
        break;
      case TextBodyType.l1:
        style = ComponentTyphography.bodyMedium()!.copyWith(
          color: ColorPalette.textBlack,
        );
      case TextBodyType.l2:
        style = ComponentTyphography.bodyMedium()!.copyWith(
          color: ColorPalette.primary,
        );
        break;
      case TextBodyType.l3:
        style = ComponentTyphography.bodyMedium()!.copyWith(
          color: ColorPalette.white,
        );
        break;
    }
    if (bold) {
      style = style.copyWith(fontWeight: FontWeight.bold);
    }
    if (colors != null) {
      style = style.copyWith(color: colors);
    }
    return Text(
      text ?? '',
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }

  static Widget titleLabel(String title, {bool bold = false}) => Row(
        children: [
          Container(
            height: 20,
            width: 2,
            margin: const EdgeInsets.only(right: 5),
            color: ColorPalette.primary,
          ),
          TextComponent.textBody(
            title,
            bold: bold,
          ),
        ],
      );

  static Widget label(String title) {
    return textBody(
      title,
    );
  }
}
