import 'package:cached_network_image/cached_network_image.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/constant.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/domain/usecase/textfield_validator.dart';
import 'package:gibas/features/approval/controller/approval_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/features/global/model/resource_response.dart';
import 'package:gibas/features/profile/view/profile_form_view.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/typography/_input_field.dart';

class ApprovalView extends GetView<ApprovalController> {
  const ApprovalView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApprovalController>(
      init: ApprovalController(), // <--- inject ke controller
      builder: (controller) {
        return BaseScaffold(
          title: 'Approval',
          usePaddingHorizontal: false,
          contentMobile: _contentMobile(context),
        );
      },
    );
  }

  Widget _contentMobile(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorPalette.secondary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                // Avatar
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [ColorPalette.primary, ColorPalette.secondary],
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: ColorPalette.grey,
                    backgroundImage: (controller.state?.fotoSelfy != null &&
                            controller.state!.fotoSelfy!.isNotEmpty)
                        ? CachedNetworkImageProvider(
                            '${Constant.baseUrlImage}/${controller.state?.fotoSelfy!}')
                        : const NetworkImage(
                                'https://avatar.iran.liara.run/public/32')
                            as ImageProvider,
                  ),
                ),

                const SizedBox(height: 16),
                Text(
                  controller.state?.fullName ?? '',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  controller.state?.email ?? '',
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 16),
                Divider(color: Colors.white.withOpacity(0.3)),
                const SizedBox(height: 16),
                // Info List
                _infoRow('Telepon', controller.state?.telepon ?? ''),
                _infoRow('Email', controller.state?.email ?? ''),
                _infoRow(
                    'Pendidikan terakhir', controller.state?.pendidikan ?? ''),
                _infoRow('Status Perkawinan',
                    controller.state?.statusPerkawinan ?? ''),
                _infoRow('Jumlah Tanggungan',
                    controller.state?.jumlahTanggungan?.toString() ?? '0'),
                _infoRow('Tempat', controller.state?.placeOfBirth ?? ''),
                _infoRow('Tanggal Lahir', controller.state?.dateOfBirth ?? ''),
                // if (controller.state?.province != null)
                //   _infoRow('Provinsi ', controller.state?.province.name ?? ''),
                // _infoRow('Kabupaten', controller.state?.regency.name ?? ''),
                const SizedBox(height: 24),
                InputField(
                  label: 'No Registrasi',
                  controller: controller.noRegController,
                  hint: 'Masukkan Nomor Registrasi',
                  inputFormatters: [],
                  validator: TextFieldValidator.number,
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
                InputField(
                  label: 'Jabatan',
                  controller: controller.jabatanController,
                  hint: 'Pilih Jabatan',
                  readOnly: true,
                  onTap: () async {
                    controller.showJabatanPicker(context);
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Navigasi ke halaman edit dan tunggu sampai kembali
                      controller
                          .approveAccount(controller.state?.confirmHash ?? '');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Approve',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Dimens.marginVerticalMedium(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      controller
                          .rejectAccount(controller.state?.confirmHash ?? '');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Reject',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
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
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: ColorPalette.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
