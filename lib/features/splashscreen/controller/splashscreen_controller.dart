import 'package:gibas/core/app/controller/auth_controller.dart';
import 'package:gibas/features/auth/view/login_view.dart';
import 'package:gibas/features/home/view/home_view.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashscreenController extends GetxController {
  late AuthController authController;
  String version = '';

  @override
  void onReady() async {
    await 2.delay();
    authController = Get.find<AuthController>();
    await authController.onCheckAuth();
    await onSetVersion();
    checkSession();

    super.onReady();
  }

  Future<void> onSetVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    authController.setVersion(version);
    update();
  }

  void checkSession() {
    if (authController.auth != null) {
      Get.offAll(() => const HomeView());
    } else {
      Get.offAll(() => const LoginView());
    }
  }
}
