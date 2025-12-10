import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        ColorScheme,
        FormState,
        GlobalKey,
        TextEditingController,
        Theme,
        showDatePicker,
        showModalBottomSheet,
        Colors,
        Icons,
        ListTile,
        TextButton;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/domain/models/base_params.dart';
import 'package:gibas/features/global/model/jenjang.dart';
import 'package:gibas/features/global/model/province.dart';
import 'package:gibas/features/global/repository/global_repository.dart';
import 'package:gibas/features/register/bottomsheet/bottomsheet_description.dart';
import 'package:gibas/features/register/bottomsheet/register_bottomsheet.dart';
import 'package:gibas/features/register/model/register_request.dart';
import 'package:gibas/features/register/repository/register_repository.dart';
import 'package:gibas/features/register/view/ktp_camera_view.dart';
import 'package:gibas/features/register/view/register_kyc_view.dart';
import 'package:gibas/features/register/view/register_view.dart';
import 'package:gibas/shared/widgets/overlay/overlay_controller.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterController extends GetxController {
  late GlobalRepository globalRepository;
  late RegisterRepository registerRepository;

  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final memberNumber = TextEditingController();
  final nikNumber = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final placeOfBirth = TextEditingController();
  final dateOfBirth = TextEditingController();
  final provinceController = TextEditingController();
  final subDistrictController = TextEditingController();
  final villageController = TextEditingController();
  final jenjangController = TextEditingController();
  // Tambahan field baru
  final pendidikanController = TextEditingController();
  final pekerjaanController = TextEditingController();
  final statusPerkawinanController = TextEditingController();
  final jumlahTanggunganController = TextEditingController();

  final noRegisterController = TextEditingController();
  final religionController = TextEditingController();
  final addressController = TextEditingController();
  List<Province> listProvince = [];
  List<Jenjang> listJenjang = [];
  final List<String> listPendidikan = [
    'SD',
    'SMP',
    'SMA/SMK',
    'D3',
    'S1',
    'S2',
    'S3',
  ];

  final List<String> listStatusPerkawinan = [
    'Belum Menikah',
    'Menikah',
    'Cerai Hidup',
    'Cerai Mati',
  ];
  IdLabel? selectedProvince;
  IdLabelDesc? selectedJenjang;
  List<IdLabel> listRegency = [];
  IdLabel? selectedRegency;
  IdLabel? selectedSubDistrict;
  IdLabel? selectedVillage;
  final regencyController = TextEditingController();

  var ktpText = ''.obs;
  var nik = ''.obs;
  var nama = ''.obs;
  File? ktpPhoto;
  bool showPassword = true;

  bool get isProvinceVisible {
    switch (selectedJenjang?.value) {
      case '2':
      case '3':
      case '4':
      case '5':
        return true;
      default:
        return false;
    }
  }

  bool get isRegencyVisible {
    switch (selectedJenjang?.value) {
      case '3':
      case '4':
      case '5':
        return true;
      default:
        return false;
    }
  }

  bool get isSubDistrictVisible {
    switch (selectedJenjang?.value) {
      case '4':
      case '5':
        return true;
      default:
        return false;
    }
  }

  bool get isVillageVisible {
    switch (selectedJenjang?.value) {
      case '5':
        return true;
      default:
        return false;
    }
  }

  @override
  void onReady() {
    globalRepository = GlobalRepository();
    registerRepository = RegisterRepository();
    fetchProvinces();
    fetchJenjang();
    super.onReady();
  }

  void fetchProvinces() async {
    try {
      final response = await globalRepository.listProvince();
      if (response.isSuccess && response.list != null) {
        listProvince = response.list!;
        Log.i('Loaded ${listProvince.length} provinces', tag: 'PROVINCE');
        update();
      } else {
        Log.e('Failed to load provinces: ${response.message}', tag: 'PROVINCE');
      }
    } catch (e, st) {
      Log.e('Error fetching provinces: $e\n$st', tag: 'PROVINCE');
    }
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

  Future<void> openCamera() async {
    // final status = await Permission.camera.request();
    // if (!status.isGranted) {
    //   Utils.toast('Camera permission denied', snackType: SnackType.error);
    //   return;
    // }
    await openImagePicker();
  }

  Future<void> processKtpImage(String path) async {
    OverlayController.to.showLoading(); // ✅ tampilkan overlay

    try {
      final inputImage = InputImage.fromFilePath(path);
      final textRecognizer = TextRecognizer();
      final recognizedText = await textRecognizer.processImage(inputImage);

      final fullText = recognizedText.text;
      final lines = fullText
          .split('\n')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      // Debug semua baris
      for (int i = 0; i < lines.length; i++) {
        Log.i('[ OCR ] Line[$i]: ${lines[i]}', tag: 'OCR');
      }

      // --- Cari NIK ---
      final nikRegex = RegExp(r'\b[\dL]{16}\b'); // terima angka + huruf L
      int nikIndex = -1;
      for (int i = 0; i < lines.length; i++) {
        if (nikRegex.hasMatch(lines[i])) {
          nik.value = nikRegex
              .firstMatch(lines[i])!
              .group(0)!
              .replaceAll('L', '1'); // perbaiki OCR salah
          nikIndex = i;
          break;
        }
      }

      // --- Cari Nama ---
      String? extractedName;
      final excludeKeywords = [
        'PROVINSI',
        'KABUPATEN',
        'KECAMATAN',
        'RT/RW',
        'KEL/DESA',
        'PEKERJAAN',
        'STATUS',
        'BERLAKU',
        'GOL',
        'WARGA',
        'AGAMA',
        'LAKILAKI',
        'LAKI-LAKI',
        'PEREMPUAN',
      ];

      // 1️⃣ Prioritas pertama: cari setelah "Pekerjaan"
      final pekerjaanIndex =
          lines.indexWhere((line) => line.toUpperCase().contains('PEKERJAAN'));
      if (pekerjaanIndex != -1) {
        for (int i = pekerjaanIndex + 1;
            i < lines.length && i <= pekerjaanIndex + 3;
            i++) {
          final text = lines[i].replaceAll(':', '').trim();
          if (RegExp(r'^[A-Z\s]+$').hasMatch(text)) {
            if (!excludeKeywords.any((k) => text.contains(k))) {
              extractedName = text;
              break;
            }
          }
        }
      }

      // 2️⃣ Kalau belum ketemu, fallback cari di bawah NIK
      if (extractedName == null && nikIndex != -1) {
        for (int i = nikIndex + 1; i < lines.length && i <= nikIndex + 5; i++) {
          final text = lines[i].replaceAll(':', '').trim();
          if (RegExp(r'^[A-Z\s]+$').hasMatch(text)) {
            if (!excludeKeywords.any((k) => text.contains(k))) {
              extractedName = text;
              break;
            }
          }
        }
      }

      nama.value = extractedName ?? '';
      Log.i('[ OCR ] Extracted NIK: ${nik.value}, Nama: ${nama.value}',
          tag: 'OCR');

      textRecognizer.close();

      Get.to(() => const RegisterView());
    } catch (e, s) {
      Log.e(
        '[ OCR ] Error saat memproses KTP: $e',
        tag: 'OCR',
      );
      Utils.toast('Gagal membaca KTP, coba lagi.', snackType: SnackType.error);
    } finally {
      OverlayController.to.hide(); // ✅ pastikan selalu hide
      Get.to(() => const RegisterView());
    }
  }

  Future<void> openImagePicker() async {
    final ImagePicker picker = ImagePicker();

    Log.i('Opening camera...', tag: 'KTP');
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 95, // ambil kualitas tinggi dulu, nanti dikompres manual
      );
      Log.i('Camera result: $pickedFile', tag: 'KTP');

      if (pickedFile != null) {
        // 🔥 Kompres gambar sebelum disimpan
        final compressedFile = await compressImage(File(pickedFile.path));

        ktpPhoto = compressedFile;
        await processKtpImage(compressedFile.path);
      } else {
        Log.i('User cancelled camera capture', tag: 'KTP');
      }
    } catch (e, st) {
      Log.e('Failed to open camera: $e\n$st', tag: 'KTP');
    }
  }

  Future<File> compressImage(File file) async {
    final maxSizeBytes = 1.7 * 1024 * 1024; // 1.7 MB
    int quality = 95;
    File resultFile = file;

    while (true) {
      final targetPath =
          "${file.parent.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg";

      final compressedBytes = await FlutterImageCompress.compressWithFile(
        resultFile.path,
        quality: quality,
      );

      if (compressedBytes == null) break;

      resultFile = File(targetPath)..writeAsBytesSync(compressedBytes);

      if (compressedBytes.lengthInBytes <= maxSizeBytes || quality <= 10) {
        // ✅ Berhenti kalau sudah <= 1.7 MB atau kualitas terlalu rendah
        break;
      }

      // 🔽 Turunkan kualitas 10% lalu coba lagi
      quality = max(quality - 10, 10);
    }

    Log.i(
        'Compressed image size: ${(resultFile.lengthSync() / 1024 / 1024).toStringAsFixed(2)} MB',
        tag: 'KTP');

    return resultFile;
  }

  void showPendidikanPicker(BuildContext context) async {
    final selected = await BottomSheetPicker.show(
      context: context,
      title: 'Pilih Pendidikan',
      items: listPendidikan
          .map((e) => IdLabel(value: listPendidikan.indexOf(e), label: e))
          .toList(),
      selected: pendidikanController.text.isNotEmpty
          ? IdLabel(
              value: listPendidikan.indexOf(pendidikanController.text),
              label: pendidikanController.text)
          : null,
    );

    if (selected != null) {
      pendidikanController.text = selected.label;
      update();
    }
  }

  void showStatusPerkawinanPicker(BuildContext context) async {
    final selected = await BottomSheetPicker.show(
      context: context,
      title: 'Pilih Status Perkawinan',
      items: listStatusPerkawinan
          .map((e) => IdLabel(value: listStatusPerkawinan.indexOf(e), label: e))
          .toList(),
      selected: statusPerkawinanController.text.isNotEmpty
          ? IdLabel(
              value:
                  listStatusPerkawinan.indexOf(statusPerkawinanController.text),
              label: statusPerkawinanController.text)
          : null,
    );

    if (selected != null) {
      statusPerkawinanController.text = selected.label;
      update();
    }
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void onNavScanKtp() {
    Get.to(() => const KtpCameraView());
  }

  void showJenjangPicker(BuildContext context) async {
    final selected = await BottomSheetPickerWithDescription.show(
      context: context,
      title: 'Pilih Jenjang',
      items: listJenjang
          .map((p) => IdLabelDesc(
                value: p.id?.toString() ?? '', // pastikan String
                label: p.name ?? '', // tampilkan name di title
                description:
                    p.description ?? '', // tampilkan description di subtitle
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
      jenjangController.text =
          selected.label; // cuma name yg ditampilkan di form
      update();
    }
  }

  void showProvincePicker(BuildContext context) async {
    final selected = await BottomSheetPicker.show(
      context: context,
      title: 'Pilih Kabupaten',
      items: listProvince
          .map((p) => IdLabel(value: p.id ?? 0, label: p.name ?? ''))
          .toList(),
      selected: selectedProvince,
    );
    if (selected != null) {
      selectedProvince = selected;
      provinceController.text = selected.label;
      update();
      listRegency = [];
      selectedRegency = null;
      regencyController.text = '';

      final result =
          await globalRepository.listRegency(provinceId: selected.value);
      if (result.isSuccess) {
        listRegency = result.list
                ?.map((r) => IdLabel(value: r.id ?? 0, label: r.name ?? ''))
                .toList() ??
            [];
        update();
      }
    }
  }

  void showRegencyPicker(BuildContext context) async {
    if (listRegency.isEmpty) {
      Utils.toast('Info, Pilih provinsi dulu', snackType: SnackType.info);
      return;
    }

    final selected = await BottomSheetPicker.show(
      context: context,
      title: 'Pilih Kabupaten',
      items: listRegency,
      selected: selectedRegency,
    );

    if (selected != null) {
      selectedRegency = selected;
      regencyController.text = selected.label;

      update();
    }
  }

  void showSubDistrictPicker(BuildContext context) async {
    if (selectedProvince == null) {
      Utils.toast('Pilih provinsi dulu', snackType: SnackType.info);
      return;
    }

    if (selectedRegency == null) {
      Utils.toast('Pilih kabupaten dulu', snackType: SnackType.info);
      return;
    }

    final params = BaseParams(
      provinceId: selectedProvince!.value.toString(),
      regencyId: selectedRegency!.value.toString(),
      perPage: '100',
    );
    Log.d('Params: ${params.toJson()}');

    final result = await globalRepository.listSubDistrict(params: params);

    if (result.isSuccess && result.data != null) {
      final listSub = result.data!.values
          .map((s) => IdLabel(value: s.id, label: s.name))
          .toList();

      if (listSub.isEmpty) {
        Utils.toast('Subdistrict tidak ditemukan', snackType: SnackType.info);
        return;
      }

      final selected = await BottomSheetPicker.show(
        context: context,
        title: 'Pilih Kecamatan',
        items: listSub,
        selected: selectedSubDistrict,
      );

      if (selected != null) {
        selectedSubDistrict = selected;
        subDistrictController.text = selected.label;
        update();
      }
    } else {
      Utils.toast('Gagal mengambil data kecamatan', snackType: SnackType.error);
    }
  }

  void showVillagePicker(BuildContext context) async {
    if (selectedProvince == null) {
      Utils.toast('Pilih provinsi dulu', snackType: SnackType.info);
      return;
    }

    if (selectedRegency == null) {
      Utils.toast('Pilih kabupaten dulu', snackType: SnackType.info);
      return;
    }

    if (selectedSubDistrict == null) {
      Utils.toast('Pilih kecamatan dulu', snackType: SnackType.info);
      return;
    }

    final params = BaseParams(
      provinceId: selectedProvince!.value.toString(),
      regencyId: selectedRegency!.value.toString(),
      subDistrictId: selectedSubDistrict!.value.toString(),
      perPage: '100',
    );
    Log.d('Params: ${params.toJson()}');

    final result = await globalRepository.listVillage(params: params);

    if (result.isSuccess && result.data != null) {
      final listVillage = result.data!.values
          .map((s) => IdLabel(value: s.id, label: s.name))
          .toList();

      if (listVillage.isEmpty) {
        Utils.toast('Village tidak ditemukan', snackType: SnackType.info);
        return;
      }

      final selected = await BottomSheetPicker.show(
        context: context,
        title: 'Pilih Desa',
        items: listVillage,
        selected: selectedVillage,
      );

      if (selected != null) {
        villageController.text = selected.label;
        selectedVillage = selected;
        Log.d('Selected village: ${selected.toJson()}');
        update();
      }
    } else {
      Utils.toast('Gagal mengambil data desa', snackType: SnackType.error);
    }
  }

  void selectDateOfBirth(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now()
          .subtract(const Duration(days: 365 * 18)), // default 18 tahun lalu
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
      dateOfBirth.text =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      update();
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

  void onRegister() {
    if (!formKey.currentState!.validate()) return;
    if (selectedJenjang == null) {
      Utils.toast("Error: Pilih Jenjang terlebih dahulu");
      return;
    }

    final request = RegisterRequest(
      fullName: name.text,
      dateOfBirth: dateOfBirth.text,
      placeOfBirth: placeOfBirth.text,
      email: email.text,
      telepon: phoneNumber.text,
      password: password.text,
      jenjangId: selectedJenjang!.value,
      confirmPassword: confirmPassword.text,
      province: selectedProvince?.value.toString() ?? '',
      regency: selectedRegency?.value.toString() ?? '',
      district: selectedSubDistrict?.value.toString() ?? '',
      village: selectedVillage?.value.toString() ?? '',
      pendidikan: pendidikanController.text,
      pekerjaan: pekerjaanController.text,
      statusPerkawinan: statusPerkawinanController.text,
      jumlahTanggungan: jumlahTanggunganController.text,
      noRegistrasi: noRegisterController.text,
      agama: religionController.text,
      alamat: addressController.text,
      fotoKtp: ktpPhoto,
    );

    Log.d(request.toJson());

    Get.to(() => const RegisterKycView(), arguments: request);
  }
}
