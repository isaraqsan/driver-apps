import 'package:gibas/core/utils/log.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/features/auth/repository/auth_repository.dart';
import 'package:gibas/features/global/model/jabatan.dart';
import 'package:gibas/features/global/model/jenjang.dart';
import 'package:gibas/features/global/model/resource_response.dart';
import 'package:gibas/features/global/repository/global_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/service/database_service.dart';
import 'package:gibas/features/profile/repository/profile_repository.dart';
import 'package:gibas/features/register/bottomsheet/bottomsheet_description.dart';
import 'package:gibas/shared/utils/dialog_helper.dart';

class ApprovalController extends GetxController with StateMixin<Resource> {
  late ProfileRepository profileRepository;
  late GlobalRepository globalRepository;
  late DatabaseService databaseService;
  final TextEditingController jabatanController = TextEditingController();
  final TextEditingController jenjangController = TextEditingController();
  final TextEditingController noRegController = TextEditingController();
  String? uuidMember;
  List<Jabatan> listJabatan = [];
  List<Jenjang> listJenjang = [];
  IdLabelDesc? selectedJabatan;
  IdLabelDesc? selectedJenjang;

  @override
  void onInit() {
    super.onInit();

    profileRepository = ProfileRepository();
    globalRepository = GlobalRepository();
    databaseService = Get.find<DatabaseService>();
    final member = Get.arguments as Resource?;
    if (member != null) {
      onGetProfile(member);
    }
    // fetchJabatan();
    fetchJenjang();

    // onGetProfile();
  }

  Future<void> onGetProfile(Resource member) async {
    change(member, status: RxStatus.success());

    if (member.jenjang != null) {
      // Set selectedJenjang dari profile
      selectedJenjang = IdLabelDesc(
        value: member.jenjang!.id?.toString() ?? '',
        label: member.jenjang!.name ?? '',
        description: member.jenjang!.description ?? '',
      );
      jenjangController.text = member.jenjang!.name ?? '';

      // Reset jabatan & load berdasarkan jenjang
      selectedJabatan = null;
      jabatanController.clear();
      await fetchJabatan();
    }

    update();
  }

  void fetchJenjang() async {
    try {
      final response = await globalRepository.listJenjang();
      if (response.isSuccess && response.list != null) {
        listJenjang = response.list!;
        Log.i('Loaded ${listJenjang.length} jenjang', tag: 'JENJANG');
        update();
      } else {
        Log.e('Failed to load jenjang: ${response.message}', tag: 'JENJANG');
      }
    } catch (e, st) {
      Log.e('Error fetching jenjang: $e\n$st', tag: 'JENJANG');
    }
  }

  Future<void> fetchJabatan() async {
    try {
      final response =
          await globalRepository.listJabatanByJenjang(selectedJenjang!.value);
      if (response.isSuccess && response.list != null) {
        listJabatan = response.list!;
        Log.i('Loaded ${listJabatan.length} jabatan', tag: 'JABATAN');
        update();
      } else {
        Log.e('Failed to load jabatan: ${response.message}', tag: 'JABATAN');
      }
    } catch (e, st) {
      Log.e('Error fetching jabatan: $e\n$st', tag: 'JABATAN');
    }
  }

  void showJenjangPicker(BuildContext context) async {
    final selected = await BottomSheetPickerWithDescription.show(
      context: context,
      title: 'Pilih Jenjang',
      items: listJenjang
          .map((p) => IdLabelDesc(
                value: p.id?.toString() ?? '',
                label: p.name ?? '',
                description: p.description ?? '',
              ))
          .toList(),
      selected: selectedJenjang != null
          ? IdLabelDesc(
              value: selectedJenjang!.value.toString(),
              label: selectedJenjang!.label,
              description: selectedJenjang!.description,
            )
          : null,
    );

    if (selected != null) {
      selectedJenjang = selected;
      jenjangController.text = selected.label;

      // reset jabatan lama, karena jenjang berubah
      selectedJabatan = null;
      jabatanController.clear();

      update();

      // baru fetch jabatan sesuai jenjang terpilih
      await fetchJabatan();
    }
  }

  void showJabatanPicker(BuildContext context) async {
    final selected = await BottomSheetPickerWithDescription.show(
      context: context,
      title: 'Pilih Jabatan',
      items: listJabatan
          .map((p) => IdLabelDesc(
              value: p.id?.toString() ?? '', // pastikan String
              label: p.name ?? '', // tampilkan name di title
              description:
                  p.description ?? '', // tampilkan description di subtitle
              isTopLevel: p.isTopLevel.toString()))
          .toList(),
      selected: selectedJabatan != null
          ? IdLabelDesc(
              value: selectedJabatan!.value.toString(),
              label: selectedJabatan!.label,
              description: selectedJabatan!.description,
            )
          : null,
    );

    if (selected != null) {
      selectedJabatan = selected;
      jabatanController.text =
          selected.label; // cuma name yg ditampilkan di form
      update();
    }
  }

  Future<void> approveAccount(String confirmHash) async {
    if (confirmHash.isEmpty) {
      Utils.toast('Data member atau konfirmasi tidak valid');
      return;
    }
    if (selectedJabatan == null) {
      Utils.toast('Silakan pilih jabatan untuk member');
      return;
    }

    Log.i(noRegController.text, tag: 'REGIS NO');

    // munculkan dialog konfirmasi dulu
    final confirm = await DialogHelper.confirm(
      title: 'Konfirmasi',
      message: 'Apakah Anda yakin ingin approve akun ini?',
    );

    if (confirm != true) {
      return; // batal
    }

    Log.d(
      'Approve account: confirmHash=$confirmHash, jabatan=${selectedJabatan!.value}',
    );

    try {
      final result = await AuthRepository().approvalAccount(
          confirmHash, 'A', selectedJabatan!.value, noRegController.text);

      if (result.isSuccess) {
        Get.back(); // Kembali ke halaman sebelumnya
        Utils.toast('Akun berhasil di-approve');
      } else {
        Utils.toast(result.message ?? 'Gagal memproses approval');
      }
    } catch (e) {
      Utils.toast('Terjadi kesalahan: $e');
    }
  }

  Future<void> rejectAccount(String confirmHash) async {
    if (confirmHash.isEmpty) {
      Utils.toast('Data member atau konfirmasi tidak valid');
      return;
    }
    if (selectedJabatan == null) {
      Utils.toast('Silakan pilih jabatan untuk member');
      return;
    }

    // munculkan dialog konfirmasi dulu
    final confirm = await DialogHelper.confirm(
      title: 'Konfirmasi',
      message: 'Apakah Anda yakin ingin reject akun ini?',
    );

    if (confirm != true) {
      return; // batal
    }

    Log.d(
      'Approve account: confirmHash=$confirmHash, jabatan=${selectedJabatan!.value}',
    );

    try {
      final result = await AuthRepository().approvalAccount(
          confirmHash, 'A', selectedJabatan!.value, noRegController.text);

      if (result.isSuccess) {
        Get.back(); // Kembali ke halaman sebelumnya
        Utils.toast('Akun berhasil di-rehect');
      } else {
        Utils.toast(result.message ?? 'Gagal memproses approval');
      }
    } catch (e) {
      Utils.toast('Terjadi kesalahan: $e');
    }
  }
}
