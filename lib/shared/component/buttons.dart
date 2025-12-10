import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' show Get, GetNavigation;
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:flutter/material.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/_text_component.dart';

enum ButtonType {
  primary,
  secondary,
  success,
  disabled,
  edit,
  cancel,
  warning,
  info,
  light,
  dark,
  white,
}

class Buttons {
  static Widget primaryButton({
    required String title,
    required VoidCallback onPressed,
    double? width,
    double? height,
    IconData? iconData,
    bool fitWidth = false,
    Color? color = ColorPalette.primary,
    ButtonType type = ButtonType.primary,
    TextBodyType textType = TextBodyType.s3,
    bool loading = false,
  }) {
    var tempColor = color;
    var textColor = ColorPalette.white;
    switch (type) {
      case ButtonType.success:
        tempColor = ColorPalette.primary;
        break;
      case ButtonType.edit:
        tempColor = ColorPalette.blueLight;
        break;
      case ButtonType.cancel:
        tempColor = ColorPalette.red;
        break;
      case ButtonType.secondary:
        tempColor = ColorPalette.secondary;
        break;
      case ButtonType.disabled:
        tempColor = ColorPalette.grey;
        break;
      default:
    }
    if (type == ButtonType.white) {
      tempColor = ColorPalette.white;
      textColor = color!;
    }
    final button = ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: tempColor,
        // shape: Component.shape(radius: 100),
        // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      child: loading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: ColorPalette.white,
                strokeWidth: 2,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (iconData != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Component.icon(iconData),
                  ),
                TextComponent.textTitle(
                  title,
                  colors: textColor,
                  bold: true,
                ),
              ],
            ),
    );

    if (fitWidth) {
      return SizedBox(
        width: fitWidth ? double.infinity : null,
        child: button,
      );
    } else {
      return button;
    }
  }

  static Widget whiteBackgorund({
    required String title,
    required VoidCallback onPressed,
    double? width,
    double? height,
    IconData? iconData,
    bool fitWidth = false,
    Color? textColor = ColorPalette.primary,
    ButtonType type = ButtonType.primary,
  }) {
    switch (type) {
      case ButtonType.cancel:
        textColor = ColorPalette.red;
        break;
      default:
    }
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorPalette.white,
        shape: Component.shape(),
        elevation: 0,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (iconData != null)
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Component.icon(iconData),
            ),
          TextComponent.textTitle(
            title,
            colors: textColor,
            // type: TextBodyType.s3,
          ),
        ],
      ),
    );

    if (fitWidth) {
      return SizedBox(
        width: fitWidth ? double.infinity : null,
        child: button,
      );
    } else {
      return button;
    }
  }

  static Widget outlineButton({
    required String title,
    required VoidCallback onPressed,
    double? width,
    double? height,
    IconData? iconData,
    bool fitWidth = false,
    Color color = ColorPalette.primary,
    ButtonType type = ButtonType.primary,
    double? iconSize,
    EdgeInsetsGeometry? padding,
  }) {
    // tentukan warna berdasarkan type
    Color borderColor = color;
    switch (type) {
      case ButtonType.success:
        borderColor = ColorPalette.greenTheme;
        break;
      case ButtonType.edit:
        borderColor = ColorPalette.blueLight;
        break;
      case ButtonType.cancel:
        borderColor = ColorPalette.red;
        break;
      case ButtonType.secondary:
        borderColor = ColorPalette.secondary;
        break;
      default:
        borderColor = color;
    }

    final btn = CupertinoButton(
      padding:
          padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      onPressed: onPressed,
      borderRadius: BorderRadius.circular(12),
      color: CupertinoColors.white, // background putih
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (iconData != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(
                iconData,
                color: borderColor,
                size: iconSize ?? 20,
              ),
            ),
          Text(
            title,
            style: TextStyle(
              color: borderColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    Widget outlined = Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: btn,
    );

    if (fitWidth) {
      return SizedBox(
        width: double.infinity,
        height: height,
        child: outlined,
      );
    } else if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: outlined,
      );
    } else {
      return outlined;
    }
  }

  static Widget button({
    required String title,
    required VoidCallback onPressed,
    double? width,
    double? height,
    Color? backgroundColor = ColorPalette.primary,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor,
        ),
        child: TextComponent.textTitle(
          title,
          colors: ColorPalette.white,
        ),
      ),
    );
  }

  static Widget buttonGreen({
    required String title,
    required VoidCallback onPressed,
    double? width,
    double? height,
    Color? backgroundColor = ColorPalette.greenTheme,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isPressed = false;

        return GestureDetector(
          onTapDown: (_) => setState(() => isPressed = true),
          onTapCancel: () => setState(() => isPressed = false),
          onTapUp: (_) {
            setState(() => isPressed = false);
            onPressed();
          },
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 120),
            opacity: isPressed ? 0.7 : 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              width: width,
              height: height,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(14), // Apple-style
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: TextComponent.textTitle(
                title,
                colors: ColorPalette.black,
                bold: true,
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget buttonIcon({
    required IconData icon,
    required VoidCallback onPressed,
    double? width,
    double? height,
    Color? backgroundColor = ColorPalette.primary,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimens.radiusExtraSmall),
          color: backgroundColor,
        ),
        child: Icon(
          icon,
          color: ColorPalette.white,
          size: 13,
        ),
      ),
    );
  }

  static Widget buttonSmall({
    required String title,
    required VoidCallback onPressed,
    double? width,
    double? height,
    Color? backgroundColor = ColorPalette.primary,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimens.radiusExtraSmall),
            color: backgroundColor,
          ),
          child: TextComponent.textBody(
            title,
            colors: ColorPalette.white,
            type: TextBodyType.s3,
          )),
    );
  }

  static Widget iconButton({
    required VoidCallback onPressed,
    required IconData icon,
    String? title,
    Color? iconColor,
    Color? backgroundColor = ColorPalette.primary,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: iconColor),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: Component.shape(radius: Dimens.radiusExtraSmall),
      ),
      label: TextComponent.textTitle(
        title,
        colors: ColorPalette.white,
        // type: TextBodyType.s3,
      ),
    );
  }

  static Widget close({String? label, Object? result}) {
    return InkWell(
      onTap: () => Get.back(result: result),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorPalette.primary),
        child: TextComponent.textBody(
          label ?? 'Mengerti',
          colors: ColorPalette.white,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
