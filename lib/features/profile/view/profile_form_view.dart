import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/theme.dart';
import 'package:gibas/domain/usecase/textfield_validator.dart';
import 'package:gibas/features/global/model/resource_response.dart';
import 'package:gibas/features/profile/controller/profile_form_controller.dart';
import 'package:gibas/features/profile/model/profile.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/typography/_input_field.dart';
import 'package:gibas/shared/typography/typography_component.dart';

class ProfileFormView extends GetView<ProfileFormController> {
  final Resource profile;

  const ProfileFormView({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileFormController>(
      init: ProfileFormController()..initProfileOnce(profile),
      builder: (controller) {
        return BaseScaffold(
          title: 'Edit Profile',
          usePaddingHorizontal: false,
          contentMobile: _contentMobile(controller, context),
        );
      },
    );
  }

  Widget _contentMobile(
      ProfileFormController controller, BuildContext context) {
    return controller.obx(
      (state) {
        // Inisialisasi controller field dengan data state
        // controller.initProfile(state!);

        return SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            children: [
              Column(
                children: [
                  TextComponent.textTitle(
                    'Foto Profile',
                    type: TextTitleType.l3,
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: controller.imageFile != null
                              ? FileImage(controller.imageFile!)
                                  as ImageProvider
                              : state?.fotoSelfy != null
                                  ? CachedNetworkImageProvider(
                                      '${Constant.baseUrlImage}${state!.fotoSelfy ?? ''}')
                                  : const AssetImage(
                                      'assets/images/avatar_placeholder.png'),
                          backgroundColor: ColorPalette.grey,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => controller.pickImage(),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: ColorPalette.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit,
                                  size: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              InputField(
                label: 'Nama Lengkap',
                controller: controller.fullNameController,
                validator: TextFieldValidator.regular,
                hint: 'Masukkan Nama Lengkap',
              ),
              InputField(
                label: 'Agama',
                controller: controller.religionController,
                hint: 'Pilih Agama',
                readOnly: true,
                onTap: () => controller.showReligionPicker(context),
                prefixIcon: CupertinoIcons.book,
              ),
              InputField(
                label: 'Email',
                controller: controller.emailController,
                validator: TextFieldValidator.email,
                hint: 'Masukkan Email',
                keyboardType: TextInputType.emailAddress,
              ),
              InputField(
                label: 'Telepon',
                controller: controller.teleponController,
                validator: TextFieldValidator.regular,
                hint: 'Masukkan Nomor Telepon',
                keyboardType: TextInputType.phone,
              ),
              InputField(
                label: 'Tempat Lahir',
                controller: controller.placeOfBirthController,
                validator: TextFieldValidator.regular,
                hint: 'Masukkan Tempat Lahir',
              ),
              InputField(
                label: 'Tanggal Lahir',
                controller: controller.dateOfBirthController,
                validator: TextFieldValidator.regular,
                hint: 'Pilih Tanggal Lahir',
                keyboardType: TextInputType.datetime,
                prefixIcon: CupertinoIcons.calendar,
                readOnly: true,
                onTap: () => controller.selectDateOfBirth(context),
              ),
              InputField(
                label: 'Alamat',
                controller: controller.addressController,
                validator: TextFieldValidator.regular,
                hint: 'Masukkan Alamat',
                keyboardType: TextInputType.streetAddress,
              ),

              const SizedBox(height: 24),

// Foto Profil Baru
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent.textTitle(
                    'Pas Foto',
                    type: TextTitleType.l3,
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: controller.imageFoto != null
                            ? Image.file(
                                controller.imageFoto!,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : state?.imageFoto != null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        '${Constant.baseUrlImage}${state!.imageFoto ?? ''}',
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: double.infinity,
                                    height: 200,
                                    color: ColorPalette.grey,
                                    child: const Center(
                                        child: Text('Upload Foto Profil')),
                                  ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => controller.pickImageProfile(),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: ColorPalette.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.edit,
                                size: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Dimens.marginVerticalLarge(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent.textTitle(
                    'Foto KTP',
                    type: TextTitleType.l3,
                  ),
                  const SizedBox(height: 8),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: controller.imageFileKtp != null
                            ? Image.file(
                                controller.imageFileKtp!,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              )
                            : state?.fotoKtp != null
                                ? CachedNetworkImage(
                                    imageUrl:
                                        '${Constant.baseUrlImage}${state!.fotoKtp ?? ''}',
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    width: double.infinity,
                                    height: 200,
                                    color: ColorPalette.grey,
                                    child: const Center(
                                        child: Text('Upload Foto KTP')),
                                  ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () => controller.pickImageKtp(),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: ColorPalette.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.edit,
                                size: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final success = await controller.updateProfile();
                    if (success) {
                      Get.back(result: true);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPalette.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      onLoading: const Center(
        child: CircularProgressIndicator(color: ColorPalette.primary),
      ),
      onError: (error) => Center(child: Text('Terjadi kesalahan: $error')),
      onEmpty: const Center(child: Text('Data profil tidak tersedia')),
    );
  }
}
