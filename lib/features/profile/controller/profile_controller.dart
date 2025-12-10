import 'package:gibas/core/app/constant/hive_key.dart';
import 'package:gibas/core/app/controller/auth_controller.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/features/auth/model/auth.dart';
import 'package:gibas/features/auth/repository/auth_repository.dart';
import 'package:gibas/features/global/model/resource_response.dart';
import 'package:gibas/features/profile/domain/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/service/database_service.dart';
import 'package:gibas/features/profile/model/profile.dart';
import 'package:gibas/features/profile/repository/profile_repository.dart';

import 'package:gibas/shared/utils/dialog_helper.dart';
import 'package:gibas/shared/widgets/overlay/overlay_controller.dart';

class ProfileController extends GetxController with StateMixin<Resource> {
  late ProfileRepository profileRepository;
  List<ProfileMenu> listMenu = [
    ProfileMenu(
        title: 'Ubah Profile',
        icon: Icons.manage_accounts,
        profileMenuKey: ProfileMenuKey.edit),
    ProfileMenu(
        title: 'Password',
        icon: Icons.password,
        profileMenuKey: ProfileMenuKey.password),
    ProfileMenu(
        title: 'Rate',
        icon: Icons.thumb_up,
        profileMenuKey: ProfileMenuKey.rate),
    ProfileMenu(
        title: 'Logout',
        icon: Icons.exit_to_app,
        profileMenuKey: ProfileMenuKey.logout),
  ];
  late DatabaseService databaseService;

  @override
  void onReady() {
    profileRepository = ProfileRepository();
    databaseService = Get.find<DatabaseService>();
    onGetProfile();
    super.onReady();
  }

  Future<void> onGetProfile() async {
    OverlayController.to.showLoading();
    change(null, status: RxStatus.loading());
    final auth = AuthController.instance.auth?.userdata?.resourceUuid;
    try {
      final result = await profileRepository.getProfile(auth ?? '');

      if (result.isSuccess && result.data != null) {
        change(result.data, status: RxStatus.success());
        OverlayController.to.hide();
      } else {
        // Kalau gagal, bisa update state error
        change(null,
            status: RxStatus.error(result.message ?? 'Gagal load profile'));
        OverlayController.to.hide();
      }
    } catch (e) {
      // Kalau ada exception
      change(null, status: RxStatus.error(e.toString()));
      OverlayController.to.hide();
    }
  }

  Future<void> onRefresh() async {
    await onGetProfile();
  }

  Future<void> deleteAccount() async {
    final uuid = AuthController.instance.auth?.userdata?.resourceUuid;
    if (uuid == null || uuid.isEmpty) {
      Utils.toast('ID pengguna tidak ditemukan.', snackType: SnackType.error);
      return;
    }

    final confirm = await DialogHelper.confirm(
      title: 'Konfirmasi',
      message:
          'Apakah Anda yakin ingin menghapus akun ini? Tindakan ini tidak dapat dibatalkan.',
    );

    if (confirm != true) return;

    OverlayController.to.showLoading();

    try {
      final result = await profileRepository.delete(uuid);
      OverlayController.to.hide();

      if (result.isSuccess) {
        // Hapus data login lokal
        await AuthController.instance.onLogout();
      } else {
        Utils.toast(result.message ?? 'Gagal menghapus akun.',
            snackType: SnackType.error);
      }
    } catch (e) {
      Utils.toast(e.toString(), snackType: SnackType.error);
    }
  }

  Future<void> onClickMenu(ProfileMenuKey profileMenuKey) async {
    switch (profileMenuKey) {
      case ProfileMenuKey.logout:
        final confirm = await DialogHelper.confirm(
            title: 'Logout', message: 'Apakah anda yakin ingin logout?');
        if (confirm ?? false) {
          AuthController.instance.onLogout();
        }
        break;
      case ProfileMenuKey.pjp:
      // Get.to(() => SetupPjpView());
      default:
        Utils.toast('Feature belum tersedia');
        break;
    }
  }
}
