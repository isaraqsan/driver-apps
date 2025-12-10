import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/theme.dart';
import 'package:gibas/domain/usecase/textfield_validator.dart';
import 'package:gibas/features/auth/controller/verify_account_controller.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/component/buttons.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/_input_field.dart';

class VerifyAccountView extends GetView<VerifyAccountController> {
  const VerifyAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerifyAccountController>(
      init: VerifyAccountController(),
      builder: (controller) {
        return BaseScaffold(
          title: 'Verifikasi Akun',
          contentMobile: _contentMobile(),
          contentTablet: _contentTablet(),
          resizeToAvoidBottomInset: true,
        );
      },
    );
  }

  Widget _contentMobile() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              _infoCard(
                'Kami telah mengirim kode verifikasi ke email yang terdaftar. '
                'Silakan cek email Anda, salin text nya dan masukkan kode di bawah ini untuk mengaktifkan akun.',
              ),
              const SizedBox(height: 20),
              InputField(
                label: 'Kode Verifikasi',
                controller: controller.codeController,
                hint: 'Masukkan kode verifikasi',
                keyboardType: TextInputType.text,
                prefixIcon: CupertinoIcons.lock,
                inputFormatters: [],
              ),
              const SizedBox(height: 30),
              Buttons.button(
                title: 'Verifikasi',
                onPressed: controller.onVerify,
                backgroundColor: ColorPalette.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contentTablet() {
    return Center(
      child: SizedBox(
        width: 400,
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              _infoCard(
                'Kami telah mengirim kode verifikasi ke email yang terdaftar. '
                'Silakan cek email Anda, salin text nya dan masukkan kode di bawah ini untuk mengaktifkan akun.',
              ),
              const SizedBox(height: 20),
              InputField(
                label: 'Kode Verifikasi',
                controller: controller.codeController,
                hint: 'Masukkan kode verifikasi',
                keyboardType: TextInputType.text,
                prefixIcon: CupertinoIcons.lock,
              ),
              const SizedBox(height: 30),
              Buttons.button(
                title: 'Verifikasi',
                onPressed: controller.onVerify,
                backgroundColor: ColorPalette.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            CupertinoIcons.mail_solid,
            color: ColorPalette.secondary,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
