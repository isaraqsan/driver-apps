import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/constant/responsive.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final String? title;
  final Widget contentMobile;
  final Widget? contentTablet;
  final Widget? contentDesktop;
  final bool? resizeToAvoidBottomInset;
  final bool usePaddingHorizontal;
  final void Function()? onTapFab;
  final PreferredSizeWidget? bootom;
  final Color? backgroundColor; // << tambahan parameter

  const BaseScaffold({
    super.key,
    this.title,
    this.resizeToAvoidBottomInset,
    this.usePaddingHorizontal = true,
    required this.contentMobile,
    this.contentTablet,
    this.contentDesktop,
    this.bootom,
    this.onTapFab,
    this.backgroundColor, // << parameter baru
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: title != null
            ? Component.appBarDefault(title!, bottom: bootom)
            : null,
        backgroundColor: backgroundColor ?? ColorPalette.white2, // << pakai default jika null
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        floatingActionButton: onTapFab != null
            ? Component.floatingActionButton(onTap: onTapFab!)
            : null,
        body: SafeArea(
          child: Padding(
            padding: usePaddingHorizontal
                ? Dimens.marginContentHorizontal
                : EdgeInsets.zero,
            child: _getResponsiveContent(context),
          ),
        ),
      ),
    );
  }

  Widget _getResponsiveContent(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Log.v('Width => $width', tag: runtimeType.toString());
    if (width <= Responsive.smallMobile.maxWidth ||
        width < Responsive.mobile.maxWidth) {
      return contentMobile;
    } else if (width <= Responsive.tablet.maxWidth) {
      return contentTablet ?? contentMobile;
    } else if (width > Responsive.tablet.maxWidth) {
      return contentDesktop ?? contentTablet ?? contentMobile;
    } else {
      return contentMobile;
    }
  }
}
