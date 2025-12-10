import 'package:flutter/material.dart' show BorderRadius, BorderSide, Icon, IconData, InkWell, InputDecoration, OutlineInputBorder, TextStyle;
import 'package:gibas/core/app/color_palette.dart';

class TextfieldComponent {
  static InputDecoration outline(
    String hint, {
    IconData? iconPrefix,
    IconData? suffixIcon,
    Function()? onTapSuffix,
  }) {
    return InputDecoration(
      fillColor: ColorPalette.white,
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.grey.withAlpha(100)),
        borderRadius: BorderRadius.circular(5),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorPalette.grey.withAlpha(100)),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: ColorPalette.primary.withAlpha(100)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: ColorPalette.red.withAlpha(100)),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: ColorPalette.grey.withAlpha(100)),
      ),
      prefixIcon: iconPrefix != null
          ? Icon(
              iconPrefix,
              color: ColorPalette.primary,
              size: 20,
            )
          : null,
      suffixIcon: suffixIcon != null
          ? InkWell(
              onTap: onTapSuffix,
              child: Icon(
                suffixIcon,
                color: ColorPalette.primary,
                size: 20,
              ),
            )
          : null,
      counterText: '',
      hintText: hint,
      // contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      hintStyle: const TextStyle(
        fontSize: 12.0,
        color: ColorPalette.textGrey,
      ),
    );
  }
}
