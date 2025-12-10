import 'package:firebase_auth/firebase_auth.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/features/auth/model/login_request.dart';
import 'package:gibas/features/auth/repository/auth_repository.dart';
import 'package:gibas/features/dashboard/presentation/view/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends GetxController {
  late AuthRepository authRepository;
  final formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = true;

  @override
  void onReady() {
    authRepository = AuthRepository();
    super.onReady();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  Future<void> onLogin() async {
    final loginRequest = LoginRequest(
      username: usernameController.text,
      password: passwordController.text,
    );

    if (loginRequest.username == 'testing' &&
        loginRequest.password == 'testing') {
      Get.offAll(() => const DashboardView(), transition: Transition.fade);
      return;
    }
  }

  Future<void> onNavForgotPassword() async {
    // Get.to(() => const ForgotPasswordView(), transition: Transition.fade);
  }

  Future<void> onNavRegister() async {
    // Get.off(() => const LandingKtpView(), transition: Transition.fade);
  }

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; 

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      final user = FirebaseAuth.instance.currentUser;
      Log.i('User Google: ${user?.email}', tag: 'LOGIN_GOOGLE');
      Log.i('User Google Name: ${user?.displayName}', tag: 'LOGIN_GOOGLE');

      Get.snackbar('Berhasil', 'Login via Google sukses!');
    } catch (e) {
      Get.snackbar('Error', 'Gagal login Google: $e');
      Log.e('Gagal login Google: $e', tag: 'LOGIN_GOOGLE');
    }

    // await FirebaseAuth.instance.signOut();
    // await GoogleSignIn().signOut();
    // final user = FirebaseAuth.instance.currentUser;
    // Log.i('User Google: ${user?.email}', tag: 'LOGIN_GOOGLE');
    // Log.i('User Google Name: ${user?.displayName}', tag: 'LOGIN_GOOGLE');
  }

  Future<void> signInWithApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );

      final oauthCredential = OAuthProvider('apple.com').credential(
        idToken: credential.identityToken,
        accessToken: credential.authorizationCode,
      );

      await _auth.signInWithCredential(oauthCredential);
      Get.snackbar('Berhasil', 'Login via Apple sukses!');
    } catch (e) {
      Get.snackbar('Error', 'Gagal login Apple: $e');
    }
  }
}
