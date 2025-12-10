import 'package:gibas/core/app/theme.dart' show ColorPalette, Dimens;
import 'package:gibas/domain/usecase/textfield_validator.dart';
import 'package:gibas/shared/typography/typhography.dart';
import 'package:gibas/shared/typography/typography_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum InputFieldStyle {
  card,
  outline,
  underline,
  fill,
  none,
}

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? Function(String?)? validator;
  final String? hint;
  final int? maxLines;
  final int? minLines;
  final bool? readOnly;
  final bool? enabled;
  final bool? obscureText;
  final EdgeInsets? margin;
  final TextInputType? keyboardType;
  final bool? isRequired;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final InputFieldStyle? style;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final void Function()? onTapSuffix;
  final void Function(String)? onChanged;
  final Iterable<String>? autofillHints;
  final FocusNode? focusNode;

  const InputField({
    this.controller,
    this.label,
    this.validator,
    this.hint,
    this.maxLines = 1,
    this.minLines = 1,
    this.readOnly,
    this.enabled,
    this.obscureText,
    this.margin,
    this.keyboardType,
    this.isRequired = false,
    this.inputFormatters,
    this.onTap,
    this.style = InputFieldStyle.outline,
    this.prefixIcon,
    this.suffixIcon,
    this.onTapSuffix,
    this.onChanged,
    this.autofillHints,
    this.focusNode,
    super.key,
  });

  final TextStyle? hintStyle = const TextStyle(fontSize: 14.0, color: ColorPalette.textGrey, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? Dimens.marginInputField,
      child: _content(),
    );
  }

  Widget _content() {
    if (label != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(),
          Dimens.marginVerticalMedium(),
          _textField(),
        ],
      );
    } else {
      return _textField();
    }
  }

  Widget _textField() {
    switch (style) {
      case InputFieldStyle.card:
        return Container(
          decoration: BoxDecoration(
            color: ColorPalette.white,
            borderRadius: BorderRadius.circular(Dimens.radiusMedium),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: TextFormField(
            keyboardType: keyboardType,
            style: TextComponent.textFieldInputStyle(),
            validator: validator,
            controller: controller,
            readOnly: readOnly ?? false,
            enabled: enabled ?? true,
            obscureText: obscureText ?? false,
            maxLines: maxLines,
            minLines: minLines,
            onTap: onTap,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            decoration: _textFieldDecoration(),
            errorBuilder: (context, errorText) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 5),
                child: TextComponent.textBody(
                  errorText,
                  colors: ColorPalette.red,
                ),
              );
            },
          ),
        );
      default:
        return TextFormField(
          keyboardType: keyboardType,
          style: TextComponent.textFieldInputStyle(),
          validator: validator,
          controller: controller,
          readOnly: readOnly ?? false,
          enabled: enabled ?? true,
          obscureText: obscureText ?? false,
          maxLines: maxLines,
          minLines: minLines,
          onTap: onTap,
          focusNode: focusNode,
          autofillHints: autofillHints,
          onChanged: onChanged,
          inputFormatters: inputFormatters ?? TextFieldValidator.inputFormatterRegular(),
          decoration: _textFieldDecoration(),
        );
    }
  }

  InputDecoration _textFieldDecoration() {
    switch (style) {
      case InputFieldStyle.card:
        final InputBorder border = OutlineInputBorder(
          borderSide: const BorderSide(color: ColorPalette.greyBackground),
          borderRadius: BorderRadius.circular(Dimens.radiusSmall),
        );
        return InputDecoration(
          fillColor: ColorPalette.greyBackground,
          filled: true,
          // border: border,
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border,
          disabledBorder: border,
          hintText: hint,
          suffixIcon: suffixIcon != null
              ? InkWell(
                  onTap: onTapSuffix,
                  child: Icon(
                    suffixIcon,
                    color: ColorPalette.primary,
                    size: Dimens.iconSizeSmall20,
                  ),
                )
              : null,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: ColorPalette.primary,
                  size: Dimens.iconSizeSmall20,
                )
              : null,
          focusedErrorBorder: border,
          hintStyle: hintStyle,
        );
      case InputFieldStyle.outline:
        return InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: ColorPalette.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.red.withAlpha(100), width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorPalette.red.withAlpha(100), width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hint,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: suffixIcon != null
              ? InkWell(
                  onTap: onTapSuffix,
                  child: Icon(
                    suffixIcon,
                    color: ColorPalette.primary,
                    size: Dimens.iconSizeSmall20,
                  ),
                )
              : null,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: ColorPalette.primary,
                  size: Dimens.iconSizeSmall20,
                )
              : null,
        );
      case InputFieldStyle.fill:
        final Color color = ColorPalette.white2;
        final radius = BorderRadius.circular(Dimens.radiusSmall12);
        final InputBorder border = OutlineInputBorder(
          borderSide: BorderSide(color: color),
          borderRadius: radius,
        );
        return InputDecoration(
          fillColor: color,
          filled: true,
          border: border,
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border,
          disabledBorder: border,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: ColorPalette.black2,
                  size: 20,
                )
              : null,
          suffixIcon: suffixIcon != null
              ? InkWell(
                  onTap: onTapSuffix,
                  child: Icon(
                    suffixIcon,
                    color: ColorPalette.black2,
                    size: 20,
                  ),
                )
              : null,
          counterText: '',
          hintText: hint,
          contentPadding: const EdgeInsets.only(right: 10, left: 10, top: 10),
          hintStyle: hintStyle,
        );
      default:
        final InputBorder border = OutlineInputBorder(
          borderSide: const BorderSide(color: ColorPalette.grey),
          borderRadius: BorderRadius.circular(Dimens.radiusSmall8),
        );
        return InputDecoration(
          fillColor: ColorPalette.white,
          filled: true,
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(borderSide: const BorderSide()),
          errorBorder: border.copyWith(borderSide: BorderSide(color: ColorPalette.red.withAlpha(100))),
          disabledBorder: border,
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          hintStyle: const TextStyle(fontSize: 12.0, color: ColorPalette.textGrey, fontWeight: FontWeight.w500),
          suffix: suffixIcon != null
              ? InkWell(
                  onTap: onTapSuffix,
                  child: Icon(suffixIcon, color: ColorPalette.primary),
                )
              : null,
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: ColorPalette.primary,
                )
              : null,
        );
    }
  }

  RichText _label() {
    TextStyle? textStyle = ComponentTyphography.bodySmall()!.copyWith(color: ColorPalette.textBlack);
    switch (style) {
      case InputFieldStyle.card:
        textStyle = ComponentTyphography.bodySmall()!.copyWith(color: ColorPalette.white, fontWeight: FontWeight.bold);
        break;
      case InputFieldStyle.fill:
      case InputFieldStyle.outline:
        textStyle = ComponentTyphography.bodyLarge()!.copyWith(color: ColorPalette.white, fontWeight: FontWeight.normal);
        break;
      default:
    }
    return RichText(
      text: TextSpan(
        text: label,
        style: textStyle,
        children: isRequired!
            ? const [
                TextSpan(
                  text: ' *',
                  style: TextStyle(color: Colors.red),
                ),
              ]
            : [],
      ),
    );
  }
}
