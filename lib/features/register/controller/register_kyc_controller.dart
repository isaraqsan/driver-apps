import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/features/auth/view/login_view.dart';
import 'package:gibas/features/register/model/register_request.dart';
import 'package:gibas/features/register/repository/register_repository.dart';
import 'package:gibas/shared/utils/dialog_helper.dart';

class RegisterKycController extends GetxController {
  String? selfieImage;
  String? profileImage;
  late RegisterRequest request;
  late RegisterRepository registerRepository;
  final email = TextEditingController();
  final memberNumber = TextEditingController();
  final nikNumber = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  bool showPassword = true;
  final formKey = GlobalKey<FormState>();

  @override
  void onReady() {
    super.onReady();
    request = Get.arguments as RegisterRequest;
    registerRepository = RegisterRepository();
  }

  void onSelfieImage(File? image) {
    selfieImage = image?.path;
    update();
  }

  void onProfileImage(File? image) {
    profileImage = image?.path;
    update();
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void onVerification() async {
    // Update request sebelum dikirim
    if (!formKey.currentState!.validate()) return;

    if (profileImage == null) {
      Utils.toast('Foto profile wajib diisi', snackType: SnackType.error);
      return;
    }
    if (selfieImage == null) {
      Utils.toast('Foto selfie wajib diisi', snackType: SnackType.error);
      return;
    }
    request
      ..fotoSelfy = selfieImage != null ? File(selfieImage!) : null
      ..imageFoto = profileImage != null ? File(profileImage!) : null
      ..telepon = phoneNumber.text
      ..email = email.text
      ..password = password.text
      ..confirmPassword = confirmPassword.text;

    Log.i(
      'Submitting registration with data: ${await request.toMultipartMap()}',
      tag: 'REGISTER',
    );

    final result = await registerRepository.registerUser(request);

    if (result.isSuccess) {
      await DialogHelper.info(
        title: 'Registrasi Berhasil',
        message:
            'Verifikasi akan dikirim melalui Email. Mohon tunggu beberapa saat.',
      );

      Get.offAll(() => const LoginView());
    } else {
      Utils.toast(result.message ?? 'Gagal registrasi',
          snackType: SnackType.error);
    }
  }
}
