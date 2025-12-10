import 'package:cached_network_image/cached_network_image.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/constant.dart';
import 'package:gibas/core/app/theme.dart';
import 'package:gibas/features/member/bottomsheet/card_bottomsheet.dart';
import 'package:gibas/features/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/features/profile/view/member_card_view.dart';
import 'package:gibas/features/profile/view/profile_form_view.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/component/buttons.dart';
import 'package:gibas/shared/component/component.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return BaseScaffold(
          title: 'Profile',
          usePaddingHorizontal: false,
          contentMobile: _contentMobile(),
        );
      },
    );
  }

  Widget _contentMobile() {
    return controller.obx(
      (state) {
        return RefreshIndicator(
          onRefresh: () async => await controller.onRefresh(),
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              children: [
                // Profile Card
                Container(
                  decoration: Component.shadow2(color: ColorPalette.greyBackground2),
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Column(
                    children: [
                      // Avatar
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              ColorPalette.primary,
                              ColorPalette.secondary
                            ],
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: ColorPalette.textTitle,
                          backgroundImage: (state?.fotoSelfy != null &&
                                  state!.fotoSelfy!.isNotEmpty)
                              ? CachedNetworkImageProvider(
                                  '${Constant.baseUrlImage}${state.fotoSelfy!}')
                              : const NetworkImage(
                                      'https://avatar.iran.liara.run/public/32')
                                  as ImageProvider,
                        ),
                      ),

                      const SizedBox(height: 16),
                      Text(
                        state?.fullName ?? '',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.textTitle,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${state?.jenjang?.name ?? ''} - ${state?.jabatan?.name ?? ''}',
                        style: const TextStyle(
                            fontSize: 14, color: ColorPalette.textTitle),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state?.email ?? '',
                        style: const TextStyle(
                            fontSize: 14, color: ColorPalette.textTitle),
                      ),
                      const SizedBox(height: 16),
                      const Divider(color: ColorPalette.textTitle),
                      const SizedBox(height: 16),
                      // Info List
                      if (state?.nomorRegistrasi != null &&
                          state?.nomorRegistrasi != 0)
                        _infoRow('No Registrasi', state?.nomorRegistrasi ?? ''),
                      if (state?.agama != null && state?.agama != 0)
                        _infoRow('Agama', state?.agama ?? ''),
                      _infoRow('Telepon', state?.telepon ?? ''),

                      _infoRow('Tempat', state?.placeOfBirth ?? ''),
                      _infoRow('Tanggal Lahir', state?.dateOfBirth ?? ''),
                      _infoRow('Pekerjaan', state?.pekerjaan ?? ''),
                      _infoRow('Pendidikan terakhir', state?.pendidikan ?? ''),
                      _infoRow(
                          'Status Perkawinan', state?.statusPerkawinan ?? ''),
                      if (state?.jumlahTanggungan != null &&
                          state?.jumlahTanggungan != 0)
                        _infoRow('Jumlah Tanggungan',
                            state?.jumlahTanggungan.toString() ?? '0'),
                      if (state?.province.name != null &&
                          state?.province.name != 0)
                        _infoRow(
                            'Provinsi', state?.province.name.toString() ?? ''),

                      if (state?.regency.name != null &&
                          state?.regency.name != 0)
                        _infoRow('Kabupaten/Kota',
                            state?.regency.name.toString() ?? ''),
                      if (state?.subDistrict?.name != null &&
                          state?.subDistrict?.name != 0)
                        _infoRow('Kecamatan',
                            state?.subDistrict?.name.toString() ?? ''),
                      if (state?.village?.name != null &&
                          state?.village?.name != 0)
                        _infoRow('Desa/Kelurahan',
                            state?.village?.name.toString() ?? ''),
                      Dimens.marginVerticalLarge(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await Get.to(() => const MemberCardView());

                            // Setelah kembali dari halaman edit, refresh profile
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPalette.greenTheme,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Lihat / Unduh kartu anggota',
                            style: TextStyle(
                              color: ColorPalette.black,
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Dimens.marginVerticalMedium(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Navigasi ke halaman edit dan tunggu sampai kembali
                            await Get.to(() =>
                                ProfileFormView(profile: controller.state!));

                            // Setelah kembali dari halaman edit, refresh profile
                            await controller.onGetProfile();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPalette.greenTheme,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: ColorPalette.black,
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Dimens.marginVerticalMedium(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await controller.deleteAccount();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.red)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Hapus Akun',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
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

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              color: ColorPalette.textTitle,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: ColorPalette.textTitle,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
