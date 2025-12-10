import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/widgets/bottom_icon.dart';
import '../controller/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (controller) {
        return BaseScaffold(
          usePaddingHorizontal: false,
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorPalette.primary, // ⬅ penting
          contentMobile: _contentMobile(controller),
        );
      },
    );
  }

  Widget _contentMobile(DashboardController controller) {
    return controller.obx(
      (state) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: controller.onPopInvokedWithResult,
          child: Stack(
            children: [
              // ======================
              // HALAMAN AKTIF
              // ======================
              Positioned.fill(
                child: controller.pages[controller.index],
              ),

              // ======================
              // BOTTOM BAR APPLE STYLE
              // ======================
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: ColorPalette.primary.withOpacity(0.55),
                        border: const Border(
                          top: BorderSide(
                            color: Colors.white12,
                            width: 0.4,
                          ),
                        ),
                      ),
                      child: CupertinoTabBar(
                        currentIndex: controller.index,
                        onTap: controller.changeTab,
                        backgroundColor: Colors.transparent,
                        activeColor: ColorPalette.greenTheme,
                        inactiveColor: Colors.white.withOpacity(0.7),
                        iconSize: 24,
                        items: List.generate(
                          state?.length ?? 0,
                          (index) => BottomNavigationBarItem(
                            icon: BottomIcon(path: state?[index].icon ?? ''),
                            activeIcon: BottomIcon(
                              path: state?[index].icon ?? '',
                              isActive: true,
                            ),
                            label: state?[index].title ?? '',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
