import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/shared/widgets/overlay/animated_loading_logo.dart';
import 'package:flutter/widgets.dart' show FocusManager;
import 'package:get/get.dart';

class OverlayController extends GetxController with GetSingleTickerProviderStateMixin {
  static OverlayController get to => Get.find();

  void showLoading() {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.dialog(
      const AnimatedLoadingLogo(),
      barrierColor: ColorPalette.black.withValues(alpha: 0.6),
    );
  }

  void hide() {
    if (Get.isDialogOpen!) Get.back();
  }
}
