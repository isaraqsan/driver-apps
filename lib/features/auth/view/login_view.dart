import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/theme.dart';
import 'package:gibas/features/auth/controller/login_cotroller.dart';

import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/component/buttons.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return BaseScaffold(
          usePaddingHorizontal: false,
          contentMobile: _contentMobile(context),
          contentTablet: _contentMobile(context),
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorPalette.primary,
        );
      },
    );
  }

  Widget _contentMobile(BuildContext context) {
    return Stack(
      children: [
        // --- Background Gradient sesuai tema warna ---
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorPalette.primary,
                ColorPalette.secondary,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),

        Column(
          children: [
            const SizedBox(height: 90),
            Center(
              child: Image.asset(
                IconsPath.logoWhite,
                height: 80,
              ),
            ),
            const SizedBox(height: 20),

            // --- Frosted Glass Dark Card ---
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(32)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: loginForm(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget loginForm(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: ListView(
        padding: const EdgeInsets.only(top: 32),
        children: [
          const Text(
            "Welcome to\nDriver Application",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 32),

          // --- Username Dark Cupertino ---
          CupertinoTextField(
            controller: controller.usernameController,
            placeholder: "Username",
            placeholderStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            style: const TextStyle(color: Colors.white),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.12)),
            ),
          ),
          const SizedBox(height: 14),

          // --- Password ---
          CupertinoTextField(
            controller: controller.passwordController,
            obscureText: controller.showPassword,
            placeholder: "Password",
            placeholderStyle: TextStyle(color: Colors.white.withOpacity(0.4)),
            style: const TextStyle(color: Colors.white),
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            suffix: GestureDetector(
              onTap: controller.onChangeShowPassword,
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  controller.showPassword
                      ? CupertinoIcons.eye
                      : CupertinoIcons.eye_slash,
                  size: 20,
                  color: Colors.white70,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.12)),
            ),
          ),

          const SizedBox(height: 26),

          // --- Login Button (greenTheme) ---
          Buttons.buttonGreen(
            title: 'Login',
            onPressed: controller.onLogin,
            height: 50,
          ),

          const SizedBox(height: 24),

          Center(
            child: RichText(
              text: TextSpan(
                text: "Don't have any account? ",
                style: const TextStyle(color: Colors.white70, fontSize: 14),
                children: [
                  TextSpan(
                    text: "Register Here",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFA2E896),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = controller.onNavRegister,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),

          // --- Google Button ---
          _darkSocialButton(
            icon: 'assets/icons/icmn_google.png',
            text: 'Login with Google',
            onTap: controller.signInWithGoogle,
          ),

          const SizedBox(height: 16),

          // --- Apple Sign In ---
          if (Platform.isIOS)
            _darkSocialButton(
              icon: 'assets/icons/icmn_apple_white.png',
              text: 'Sign in with Apple',
              onTap: controller.signInWithApple,
              dark: true,
            ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _darkSocialButton({
    required String icon,
    required String text,
    required Function() onTap,
    bool dark = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: dark ? Colors.black : Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withOpacity(0.12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, height: 22, color: dark ? Colors.white : null),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: dark ? Colors.white : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
