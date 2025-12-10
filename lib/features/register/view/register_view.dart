import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/theme.dart';
import 'package:gibas/core/utils/size_config.dart';
import 'package:gibas/domain/usecase/textfield_validator.dart';
import 'package:gibas/features/register/controller/register_controller.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/component/buttons.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/_input_field.dart';
import 'package:gibas/shared/typography/typography_component.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      init: RegisterController(),
      builder: (controller) {
        return BaseScaffold(
          contentMobile: _contentMobile(context),
          contentTablet: _contentMobile(context),
          resizeToAvoidBottomInset: true,
          title: 'Data Diri',
        );
      },
    );
  }

  Widget _contentMobile(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dimens.marginVerticalXXLarge(),
            Container(
              padding: Dimens.marginContentHorizontal,
              margin: Dimens.marginContentHorizontal10,
              decoration: Component.shadow(color: ColorPalette.textTitle),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Dimens.marginVerticalLarge(),

                  InputField(
                    label: 'Nama',
                    controller: controller.name,
                    validator: TextFieldValidator.regular,
                    hint: 'Masukan Nama Lengkap',
                    keyboardType: TextInputType.text,
                    prefixIcon: CupertinoIcons.person,
                  ),

                  // Agama
                  InputField(
                    label: 'Agama',
                    controller: controller.religionController,
                    hint: 'Pilih Agama',
                    readOnly: true,
                    onTap: () => controller.showReligionPicker(context),
                    prefixIcon: CupertinoIcons.book,
                  ),
                  InputField(
                    label: 'Pendidikan',
                    controller: controller.pendidikanController,
                    hint: 'Pilih Pendidikan',
                    readOnly: true,
                    onTap: () => controller.showPendidikanPicker(context),
                    prefixIcon: CupertinoIcons.book,
                  ),
                  InputField(
                    label: 'Pekerjaan',
                    controller: controller.pekerjaanController,
                    validator: TextFieldValidator.regular,
                    hint: 'Masukan Pekerjaan',
                    keyboardType: TextInputType.text,
                    prefixIcon: CupertinoIcons.briefcase,
                  ),
                  InputField(
                    label: 'Status Perkawinan',
                    controller: controller.statusPerkawinanController,
                    hint: 'Pilih Status Perkawinan',
                    readOnly: true,
                    onTap: () => controller.showStatusPerkawinanPicker(context),
                    prefixIcon: CupertinoIcons.heart,
                  ),
                  if (controller.statusPerkawinanController.text !=
                      'Belum Menikah')
                    InputField(
                      label: 'Jumlah Tanggungan',
                      controller: controller.jumlahTanggunganController,
                      validator: TextFieldValidator.regular,
                      hint: 'Masukan Jumlah Tanggungan',
                      keyboardType: TextInputType.number,
                      prefixIcon: CupertinoIcons.person_3,
                    ),
                  InputField(
                    label: 'Tanggal Lahir',
                    controller: controller.dateOfBirth,
                    validator: TextFieldValidator.regular,
                    hint: 'Pilih Tanggal Lahir',
                    keyboardType: TextInputType.datetime,
                    prefixIcon: CupertinoIcons.calendar,
                    readOnly: true,
                    onTap: () => controller.selectDateOfBirth(context),
                  ),
                  InputField(
                    label: 'Tempat Lahir',
                    controller: controller.placeOfBirth,
                    validator: TextFieldValidator.regular,
                    hint: 'Masukan Tempat Lahir',
                    keyboardType: TextInputType.text,
                    prefixIcon: CupertinoIcons.location,
                  ),
                  InputField(
                    label: 'Alamat',
                    controller: controller.addressController,
                    validator: TextFieldValidator.regular,
                    hint: 'Masukan Alamat Lengkap',
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    prefixIcon: CupertinoIcons.map,
                  ),
                  InputField(
                    label: 'Jenjang',
                    controller: controller.jenjangController,
                    hint: 'Pilih Jenjang',
                    readOnly: true,
                    onTap: () async {
                      controller.showJenjangPicker(context);
                    },
                  ),
                  Visibility(
                    visible: controller.isProvinceVisible,
                    child: InputField(
                      isRequired: controller.isProvinceVisible,
                      validator: controller.isProvinceVisible
                          ? TextFieldValidator.regular
                          : null,
                      label: 'Provinsi',
                      controller: controller.provinceController,
                      hint: 'Pilih Provinsi',
                      readOnly: true,
                      onTap: () async {
                        controller.showProvincePicker(context);
                      },
                    ),
                  ),
                  Visibility(
                    visible: controller.isRegencyVisible,
                    child: InputField(
                      isRequired: controller.isRegencyVisible,
                      validator: controller.isRegencyVisible
                          ? TextFieldValidator.regular
                          : null,
                      label: 'Kota/Kabupaten',
                      controller: controller.regencyController,
                      hint: 'Pilih Kota/Kabupaten',
                      readOnly: true,
                      onTap: () async {
                        controller.showRegencyPicker(context);
                      },
                    ),
                  ),
                  Visibility(
                    visible: controller.isSubDistrictVisible,
                    child: InputField(
                      isRequired: controller.isSubDistrictVisible,
                      validator: controller.isSubDistrictVisible
                          ? TextFieldValidator.regular
                          : null,
                      label: 'Kecamatan',
                      controller: controller.subDistrictController,
                      hint: 'Pilih Kecamatan',
                      readOnly: true,
                      onTap: () async {
                        controller.showSubDistrictPicker(context);
                      },
                    ),
                  ),
                  Visibility(
                    visible: controller.isVillageVisible,
                    child: InputField(
                      isRequired: controller.isVillageVisible,
                      validator: controller.isVillageVisible
                          ? TextFieldValidator.regular
                          : null,
                      label: 'Keluaran/Desa',
                      controller: controller.villageController,
                      hint: 'Pilih Keluaran/Desa',
                      readOnly: true,
                      onTap: () async {
                        controller.showVillagePicker(context);
                      },
                    ),
                  ),
                  Dimens.marginVerticalXLarge(),
                  Buttons.buttonGreen(
                    title: 'Selanjutnya',
                    onPressed: controller.onRegister,
                  ),
                  Dimens.marginVerticalXLarge(),
                ],
              ),
            ),
            Dimens.marginVerticalXXXLarge(),
          ],
        ),
      ),
    );
  }

  Widget _contentTablet() {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 20),
      child: Center(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      IconsPath.logoTransparent,
                      height: Dimens.imageSizelarge,
                    ),
                    Dimens.marginHorizontalLarge(),
                    TextComponent.textTitle(
                      Constant.aplicationName,
                      type: TextTitleType.xxxl1,
                      bold: true,
                      colors: ColorPalette.primary,
                    ),
                  ],
                ),
              ),
              Dimens.marginVerticalXXLarge(),
              Container(
                padding: Dimens.marginContentHorizontal,
                margin: Dimens.marginContentHorizontal10,
                decoration: Component.shadow(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Dimens.marginVerticalXLarge(),
                    TextComponent.textTitle(
                      'Login',
                      type: TextTitleType.xl1,
                      bold: true,
                    ),
                    Dimens.marginVerticalLarge(),
                    const InputField(
                      label: 'Username',
                      // controller: controller.username,
                      validator: TextFieldValidator.regular,
                      hint: 'Masukan Username',
                      keyboardType: TextInputType.text,
                      prefixIcon: CupertinoIcons.person,
                      autofillHints: [AutofillHints.username],
                    ),
                    InputField(
                      label: 'Password',
                      obscureText: controller.showPassword,
                      // controller: controller.passwordController,
                      validator: TextFieldValidator.regular,
                      hint: 'Masukan Password',
                      prefixIcon: CupertinoIcons.lock,
                      suffixIcon: controller.showPassword
                          ? CupertinoIcons.eye
                          : CupertinoIcons.eye_slash,
                      onTapSuffix: controller.onChangeShowPassword,
                      autofillHints: const [AutofillHints.password],
                    ),
                    Dimens.marginVerticalXLarge(),
                    Buttons.button(
                        title: 'Login', onPressed: controller.onRegister),
                    Dimens.marginVerticalXLarge(),
                  ],
                ),
              ),
              Dimens.marginVerticalXXXLarge(),
            ],
          ),
        ),
      ),
    );
  }
}
