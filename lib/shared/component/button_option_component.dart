import 'package:flutter/material.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/shared/component/buttons.dart';
import 'package:gibas/shared/typography/typography_component.dart';

class ButtonOptionComponent extends StatelessWidget {
  final VoidCallback? onClick;
  final String? text;
  final IconData? iconData;
  final ButtonType? type;
  final AlignmentGeometry? alignment;

  const ButtonOptionComponent({
    required this.onClick,
    this.text,
    this.iconData,
    this.type = ButtonType.info,
    this.alignment = Alignment.center,
    super.key,
  });

  Color _getColor() {
    switch (type) {
      case ButtonType.cancel:
        return ColorPalette.red;
      default:
        return ColorPalette.blackTextTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        // height: 40,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        alignment: alignment,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: ColorPalette.whiteBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: ColorPalette.whiteBackground,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconData != null)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  iconData,
                  color: _getColor(),
                ),
              ),
            TextComponent.textBody(
              '$text',
              bold: true,
              textAlign: TextAlign.center,
              colors: _getColor(),
            ),
          ],
        ),
      ),
    );
  }
}
