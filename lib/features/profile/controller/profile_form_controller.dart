import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/controller/auth_controller.dart';
import 'package:gibas/core/service/image_compress_service.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/features/global/model/resource_response.dart';
import 'package:gibas/features/profile/model/profile.dart';
import 'package:gibas/features/profile/repository/profile_repository.dart';
import 'package:gibas/shared/widgets/overlay/overlay_controller.dart';
import 'package:image_picker/image_picker.dart';

class ProfileFormController extends GetxController with StateMixin<Resource> {
  late ProfileRepository profileRepository;

  // Field controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final teleponController = TextEditingController();
  final passwordController = TextEditingController();
  final placeOfBirthController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final noRegController = TextEditingController();
  final religionController = TextEditingController();
  final addressController = TextEditingController();

  // Dropdown / selection values
  int? roleId;
  String? roleLabel;

  int? provinceId;
  String? provinceLabel;

  int? regencyId;
  String? regencyLabel;

  int? komunitasId;
  String? komunitasLabel;

  List<int> temaId = [];

  // Image
  File? imageFile;
  File? imageFileKtp;
  File? imageFoto;

  String? auth;

  @override
  void onReady() {
    profileRepository = ProfileRepository();
    auth = AuthController.instance.auth?.userdata?.resourceUuid;
    super.onReady();
  }

  void initProfileOnce(Resource profile) {
    if (state == null) {
      initProfile(profile);
    }
  }

  void selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorPalette.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      dateOfBirthController.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      update();
    }
  }

  void initProfile(Resource profile) {
    Log.i('Initializing profile data in form controller');
    change(profile, status: RxStatus.success());
    fullNameController.text = profile.fullName;
    emailController.text = profile.email;
    teleponController.text = profile.telepon;
    placeOfBirthController.text = profile.placeOfBirth;
    dateOfBirthController.text = profile.dateOfBirth;
    noRegController.text = profile.nomorRegistrasi ?? '';
    passwordController.text = '';
    religionController.text = profile.agama ?? '';
    addressController.text = profile.alamat ?? '';

    roleId = profile.role.roleId;
    Log.d(roleId.toString(), tag: 'ROLE_ID');
    roleLabel = profile.role.roleName;

    provinceId = profile.province.id;
    provinceLabel = profile.province.name;

    regencyId = profile.regency.id;
    regencyLabel = profile.regency.name;
  }

  // Pick image from gallery
  Future<void> pickImage() async {
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: Get.context!,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Kamera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      final XFile? picked = await ImagePicker().pickImage(source: source);
      if (picked != null) {
        final File pickedFile = File(picked.path);

        File? compressedFile =
            await ImageCompressService.compressImage(pickedFile);

        if (compressedFile != null) {
          imageFile = compressedFile;
          update();
        }
      }
    }
  }

  Future<void> pickImageKtp() async {
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: Get.context!,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Kamera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      final XFile? picked = await ImagePicker().pickImage(source: source);
      if (picked != null) {
        final File pickedFile = File(picked.path);

        File? compressedFile =
            await ImageCompressService.compressImage(pickedFile);

        if (compressedFile != null) {
          imageFileKtp = compressedFile;
          update();
        }
      }
    }
  }

  Future<void> pickImageProfile() async {
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: Get.context!,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text('Kamera'),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
          ],
        ),
      ),
    );

    if (source != null) {
      final XFile? picked = await ImagePicker().pickImage(source: source);
      if (picked != null) {
        final File pickedFile = File(picked.path);

        File? compressedFile =
            await ImageCompressService.compressImage(pickedFile);

        if (compressedFile != null) {
          imageFoto = compressedFile;
          update();
        }
      }
    }
  }

  void showReligionPicker(BuildContext context) async {
    final religions = [
      'Islam',
      'Kristen',
      'Katolik',
      'Hindu',
      'Buddha',
      'Konghucu'
    ];

    final selected = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                'Pilih Agama',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...religions.map((e) {
                return ListTile(
                  title: Text(e),
                  trailing: religionController.text == e
                      ? const Icon(Icons.check, color: Colors.blue)
                      : null,
                  onTap: () => Navigator.pop(context, e),
                );
              }).toList(),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
            ],
          ),
        );
      },
    );

    if (selected != null) {
      religionController.text = selected;
      update();
    }
  }

  // Update profile
  Future<bool> updateProfile() async {
    final currentProfile = state;
    Log.i(currentProfile?.toJson());
    Log.i(fullNameController.text);
    if (currentProfile == null) {
      return false;
    }
    try {
      OverlayController.to.showLoading(); // tampilkan loading overlay

      final result = await profileRepository.updateProfile(
        uuid: auth ?? '',
        id: currentProfile.resourceId,
        roleId: roleId.toString(),
        roleLabel: roleLabel!,
        fullName: fullNameController.text,
        jenjangId: currentProfile.jenjang?.id.toString() ?? '',
        email: emailController.text,
        telepon: teleponController.text,
        password: passwordController.text,
        alamat: addressController.text,
        agama: religionController.text,
        imageFoto: imageFoto,
        fotoSelfy: imageFile,
        fotoKtp: imageFileKtp,
        placeOfBirth: placeOfBirthController.text,
        dateOfBirth: dateOfBirthController.text,
        areaRegencyId: currentProfile.areaRegenciesId.toString(),
        areaProvinceId: currentProfile.areaProvinceId.toString(),
        areaSubdistrictId: currentProfile.areaSubdistrictsId.toString(),
        areaVillageId: currentProfile.areaVillagesId.toString(),
      );

      OverlayController.to.hide();

      if (result.isSuccess) {
        change(result.data, status: RxStatus.success());

        Utils.toast('Profile berhasil diperbarui');

        Future.delayed(const Duration(milliseconds: 300), () {
          Get.back(result: true);
        });

        return true;
      } else {
        Utils.toast(result.message ?? 'Terjadi kesalahan',
            snackType: SnackType.error);
        return false;
      }
    } catch (e) {
      OverlayController.to.hide();
      Utils.toast('Terjadi kesalahan: $e', snackType: SnackType.error);
      return false;
    }
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    teleponController.dispose();
    passwordController.dispose();
    placeOfBirthController.dispose();
    dateOfBirthController.dispose();
    super.onClose();
  }
}
