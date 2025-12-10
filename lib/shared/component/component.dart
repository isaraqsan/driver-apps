import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/shared/typography/typography_component.dart'
    show TextComponent, TextTitleType;

class Component {
  static ThemeData theme() {
    return ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorPalette.primary,
        foregroundColor: ColorPalette.primary,
        elevation: 0,
        shadowColor: ColorPalette.primary,
        surfaceTintColor: ColorPalette.primary,
        iconTheme: IconThemeData(
          color: ColorPalette.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
          backgroundColor: WidgetStateProperty.all<Color>(ColorPalette.primary),
          foregroundColor: WidgetStateProperty.all<Color>(ColorPalette.white),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
          iconColor: WidgetStateProperty.all<Color>(ColorPalette.white),
        ),
      ),
      useMaterial3: false,
      colorScheme: ColorScheme.fromSwatch()
          .copyWith(
              primary: ColorPalette.primary,
              secondary: ColorPalette.secondary.withAlpha(100))
          .copyWith(
            surface: const Color(0xffF7F7F7),
          ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: ColorPalette.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        // modalBackgroundColor: ColorPalette.white,
        // modalBarrierColor: ColorPalette.white,
        // surfaceTintColor: ColorPalette.white,
      ),
      dialogTheme: DialogThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: ColorPalette.white,
        surfaceTintColor: ColorPalette.white,
        shadowColor: ColorPalette.white,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all<Color>(ColorPalette.white),
          surfaceTintColor: WidgetStateProperty.all<Color>(ColorPalette.white),
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
    );
  }

  static AppBar appbar(String title, {List<Widget>? actions}) {
    return AppBar(
      backgroundColor: ColorPalette.white,
      toolbarHeight: Dimens.heightAppBar,
      title: TextComponent.textTitle(
        title,
        bold: true,
        type: TextTitleType.l1,
      ),
      leading: InkWell(
        onTap: () => Get.back(),
        child: const Icon(
          CupertinoIcons.back,
          color: ColorPalette.white,
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }

  static AppBar appBarDefault(String title, {PreferredSizeWidget? bottom}) {
    return AppBar(
      backgroundColor: ColorPalette.white2,
      centerTitle: false,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: ColorPalette.textTitle, // Warna tombol back
      ),
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 20,
            color: ColorPalette.textTitle,
            fontWeight: FontWeight.bold),
      ),
      bottom: bottom,
    );
  }

  static AppBar appbarTitle(String title,
      {Color color = ColorPalette.primary}) {
    return AppBar(
      backgroundColor: color,
      centerTitle: false,
      title: Text(title,
          style: const TextStyle(fontSize: 20, color: Colors.white)),
    );
  }

  static Padding divider({
    double height = 5.0,
    Color color = ColorPalette.greyBorder,
    double thickness = 1,
    bool paddingVertical = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingVertical ? 16 : 0),
      child: Divider(
        height: height,
        thickness: thickness,
        // indent: 20,
        // endIndent: 0,
        color: color,
      ),
    );
  }

  static BoxDecoration shadow({Color? color = ColorPalette.black2}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: ColorPalette.white.withOpacity(0.1),
        width: 1,
      ),
      boxShadow: shadowBox(),
    );
  }

  static BoxDecoration shadow2({Color color = ColorPalette.white}) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(14),
      boxShadow: const [
        // Soft ambient shadow (iOS look)
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.08),
          blurRadius: 20,
          offset: Offset(0, 10),
        ),

        // Subtle closer shadow
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.03),
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  static BoxDecoration login({
    Color? color = ColorPalette.whiteBackground,
    bool topOnly = false,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: topOnly
          ? const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            )
          : BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, -2),
        ),
      ],
    );
  }

  static BoxDecoration shadowContainer({Color? color = ColorPalette.white}) {
    return BoxDecoration(
      color: ColorPalette.white,
      borderRadius: BorderRadius.circular(Dimens.radiusSmall),
      boxShadow: shadowBox(),
    );
  }

  static List<BoxShadow> shadowBox() {
    return [
      BoxShadow(
        color: Colors.grey.withValues(alpha: 0.1),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 1),
      ),
    ];
  }

  static InputDecoration regular({String? hint, IconData? prefixIcon}) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
    );
  }

  static InputDecoration decorationNoBorder(
    String hint, {
    IconData? iconPrefix,
    Widget? iconSuffix,
  }) {
    const radius = Radius.circular(Dimens.radiusSmall8);
    final border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(radius),
      borderSide: BorderSide(
        color: ColorPalette.grey,
        width: 1.2,
      ),
    );

    return InputDecoration(
      filled: true,
      fillColor: ColorPalette.white,
      border: border,
      enabledBorder: border,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(radius),
        borderSide: BorderSide(width: 1.5),
      ),
      prefixIcon: iconPrefix != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Icon(
                iconPrefix,
                size: 20,
                color: ColorPalette.primary.withValues(alpha: 0.9),
              ),
            )
          : null,
      prefixIconConstraints: const BoxConstraints(),
      suffixIcon: iconSuffix,
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 14,
        color: ColorPalette.textGrey,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      isDense: true,
    );
  }

  static Widget floatingActionButton({required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FloatingActionButton(
        onPressed: onTap,
        backgroundColor: ColorPalette.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  static RoundedRectangleBorder bottomsheetShape() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    );
  }

  static RoundedRectangleBorder shape({double radius = Dimens.radiusSmall}) {
    return RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
  }

  static Icon icon(IconData icon,
      {Color color = ColorPalette.white, double? size}) {
    return Icon(icon, color: color, size: size);
  }
}
