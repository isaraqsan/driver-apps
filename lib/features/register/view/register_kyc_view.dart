import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/theme.dart';
import 'package:gibas/domain/usecase/textfield_validator.dart';
import 'package:gibas/features/register/controller/register_kyc_controller.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/component/buttons.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/_input_field.dart';
import 'package:gibas/shared/widgets/photo_picker.dart';
import 'package:image_picker/image_picker.dart';

class RegisterKycView extends GetView<RegisterKycController> {
  const RegisterKycView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterKycController>(
      init: RegisterKycController(),
      builder: (controller) {
        return BaseScaffold(
          contentMobile: _contentMobile(),
          resizeToAvoidBottomInset: true,
          title: 'Buat Akun',
        );
      },
    );
  }

  Widget _contentMobile() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dimens.marginVerticalXXLarge(),
          Form(
            key: controller.formKey,
            child: Container(
              padding: Dimens.marginContentHorizontal,
              margin: Dimens.marginContentHorizontal10,
              decoration: Component.shadow(color: ColorPalette.textTitle),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Dimens.marginVerticalLarge(),
                  PhotoPicker(
                    label: 'Foto Profile',
                    path: controller.profileImage,
                    cameraDevice: CameraDevice.front,
                    onChanged: (value) => controller.onProfileImage(value),
                  ),
                  Dimens.marginVerticalXLarge(),
                  PhotoPicker(
                    label: 'Foto Selfie',
                    path: controller.selfieImage,
                    cameraDevice: CameraDevice.front,
                    onChanged: (value) => controller.onSelfieImage(value),
                  ),
                  Dimens.marginVerticalXLarge(),
                  InputField(
                    label: 'No Telepon',
                    controller: controller.phoneNumber,
                    validator: TextFieldValidator.number,
                    hint: 'Masukan no telepon',
                    keyboardType: TextInputType.phone,
                    prefixIcon: CupertinoIcons.phone,
                    autofillHints: const [AutofillHints.telephoneNumber],
                  ),
                  InputField(
                    label: 'E-Mail',
                    controller: controller.email,
                    validator: TextFieldValidator.email,
                    inputFormatters: [],
                    hint: 'Masukan E-Mail',
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: CupertinoIcons.mail,
                  ),
                  InputField(
                    label: 'Password',
                    obscureText: controller.showPassword,
                    controller: controller.password,
                    validator: TextFieldValidator.regular,
                    hint: 'Masukan Password',
                    prefixIcon: CupertinoIcons.lock,
                    suffixIcon: controller.showPassword
                        ? CupertinoIcons.eye
                        : CupertinoIcons.eye_slash,
                    onTapSuffix: controller.onChangeShowPassword,
                  ),
                  InputField(
                    label: 'Konfirmasi Password',
                    obscureText: controller.showPassword,
                    controller: controller.confirmPassword,
                    validator: TextFieldValidator.regular,
                    hint: 'Masukan Konfirmasi Password',
                    prefixIcon: CupertinoIcons.lock,
                    suffixIcon: controller.showPassword
                        ? CupertinoIcons.eye
                        : CupertinoIcons.eye_slash,
                    onTapSuffix: controller.onChangeShowPassword,
                  ),
                  Dimens.marginVerticalXLarge(),
                  Buttons.buttonGreen(
                    title: 'Daftar',
                    onPressed: controller.onVerification,
                  ),
                  Dimens.marginVerticalXLarge(),
                ],
              ),
            ),
          ),
          Dimens.marginVerticalXXXLarge(),
        ],
      ),
    );
  }
}
