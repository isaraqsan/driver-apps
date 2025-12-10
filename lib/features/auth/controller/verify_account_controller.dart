import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/controller/auth_controller.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/features/auth/model/auth.dart';
import 'package:gibas/features/auth/model/login_request.dart';
import 'package:gibas/features/auth/repository/auth_repository.dart';
import 'package:gibas/features/home/view/home_view.dart';
import 'package:gibas/shared/utils/dialog_helper.dart';
import 'package:gibas/core/utils/log.dart';

class VerifyAccountController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();
  late AuthRepository authRepository;
  late LoginRequest request;

  @override
  void onReady() {
    super.onReady();
    authRepository = AuthRepository();
    request = Get.arguments; // dari login
    Log.d(request.toJson());
  }

  @override
  void onClose() {
    codeController.dispose();
    super.onClose();
  }

  Future<void> onVerify() async {
    if (!formKey.currentState!.validate()) return;

    try {
      final result = await authRepository.verifyAccount(
        codeController.text,
      );

      if (result.isSuccess) {
        // Verifikasi sukses, langsung login
        final loginResult = await authRepository.login(request);

        if (loginResult.isSuccess) {
          // Set token dan user data di AuthController
          await AuthController.instance
              .onSetToken(loginResult.data?.accessToken);
          if (loginResult.data?.userdata != null) {
            final auth =
                Auth.fromJson({'userdata': loginResult.data!.userdata});
            await AuthController.instance.onSetAuth(auth);
          }

          // Navigasi ke Home
          Get.offAll(() => const HomeView());
        } else {
          Utils.toast('Error: ${loginResult.message ?? 'Login otomatis gagal'}',
              snackType: SnackType.error);
        }
      } else {
        Utils.toast('Error: ${result.message ?? 'Verifikasi gagal'}',
            snackType: SnackType.error);
      }
    } catch (e) {
      Log.e('Verify Error: $e');
      Utils.toast('Error: Terjadi kesalahan saat verifikasi',
          snackType: SnackType.error);
    }
  }
}
