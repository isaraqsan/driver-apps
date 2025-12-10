import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/theme.dart';
import 'package:gibas/core/utils/size_config.dart';
import 'package:gibas/features/register/controller/register_controller.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/component/buttons.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/typography_component.dart';

class LandingKtpView extends GetView<RegisterController> {
  const LandingKtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (controller) {
        return BaseScaffold(
          contentMobile: _contentMobile(context, controller),
          // contentTablet: _contentMobile(),
          resizeToAvoidBottomInset: true,
          backgroundColor: ColorPalette.textTitle,
        );
      },
    );
  }

  Widget _contentMobile(BuildContext context, RegisterController controller) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 450),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
          decoration: Component.shadow2(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon section
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: ColorPalette.greenTheme.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.credit_card,
                  size: 50,
                  color: ColorPalette.greenTheme,
                ),
              ),

              const SizedBox(height: 32),

              // Title
              TextComponent.textTitle(
                'Verifikasi Identitas Anda',
                type: TextTitleType.xxxl1,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Description
              TextComponent.textBody(
                'Kami membutuhkan KTP Anda untuk memastikan identitas dan keamanan akun Anda. '
                'Proses ini cepat dan aman, data Anda akan dijaga kerahasiaannya.',
                type: TextBodyType.l2,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 36),

              // Button
              Buttons.primaryButton(
                color: ColorPalette.textTitle,
                title: 'Ambil Foto KTP',
                textType: TextBodyType.s1,
                onPressed: controller.openCamera,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentTablet() {
    return Center(
      child: Container(
        width: 600,
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 4,
            vertical: SizeConfig.blockSizeVertical * 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextComponent.textBody(
              'Verifikasi Identitas Anda',
            ),
            const SizedBox(height: 24),
            TextComponent.textBody(
              'Kami membutuhkan KTP Anda untuk memastikan identitas dan keamanan akun Anda. '
              'Proses ini hanya memerlukan beberapa detik, dan data Anda akan dijaga kerahasiaannya.',
            ),
            const SizedBox(height: 40),
            Buttons.button(
              title: 'Lanjut ke Scan KTP',
              onPressed: () {
                controller.onNavScanKtp();
              },
            ),
          ],
        ),
      ),
    );
  }
}
