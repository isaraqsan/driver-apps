import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/constant/icons_path.dart';
import 'package:gibas/features/splashscreen/controller/splashscreen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/utils/size_config.dart';
import 'package:gibas/shared/typography/typography_component.dart';

class SplashscreenView extends StatelessWidget {
  const SplashscreenView({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetBuilder<SplashscreenController>(
      init: SplashscreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorPalette.primary,
          body: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Image.asset(
                  IconsPath.logoWhite,
                  height: SizeConfig.blockSizeHorizontal * 70,
                ),
              ),
              Positioned(
                bottom: 10.0,
                child: TextComponent.textBody(controller.version, colors: ColorPalette.white),
              )
            ],
          ),
        );
      },
    );
  }
}
