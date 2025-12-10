import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:flutter/material.dart';

class BottomIcon extends StatelessWidget {
  final String path;
  final bool isActive;
  final Color activeColor;
  final Color color;
  final String? label;

  const BottomIcon({
    super.key,
    required this.path,
    this.isActive = false,
    this.color = ColorPalette.grey,
    this.activeColor = ColorPalette.greenTheme,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      color: isActive ? activeColor : color,
      width: Dimens.iconSizeSmall20,
      height: Dimens.iconSizeSmall20,
    );
  }
}
