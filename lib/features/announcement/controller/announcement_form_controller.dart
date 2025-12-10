// File: announcement_form_controller.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/controller/auth_controller.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/features/announcement/repository/announcement_repository.dart';
import 'package:gibas/features/global/repository/global_repository.dart';
import 'package:gibas/features/announcement/model/announcement_request.dart';
import 'package:gibas/shared/widgets/overlay/overlay_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AnnouncementFormController extends GetxController {
  // Image
  final imageFile = Rx<File?>(null);

  // Form controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final startDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endDateController = TextEditingController();
  final endTimeController = TextEditingController();
  final provinceController = TextEditingController();
  final regencyController = TextEditingController();

  // State
  RxBool isSubmitting = false.obs;

  // Repository
  late GlobalRepository globalRepository;
  late AnnouncementRepository announcementRepository;

  @override
  void onInit() {
    super.onInit();
    globalRepository = GlobalRepository();
    announcementRepository = AnnouncementRepository();
    // fetchProvinces();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    startDateController.dispose();
    startTimeController.dispose();
    endDateController.dispose();
    endTimeController.dispose();
    provinceController.dispose();
    regencyController.dispose();
    super.onClose();
  }

  /// =========================
  /// PICK DATE & TIME
  /// =========================
  Future<void> pickStartDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) {
      startDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> pickStartTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      startTimeController.text = picked.format(context);
    }
  }

  Future<void> pickEndDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (picked != null) {
      endDateController.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> pickEndTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      endTimeController.text = picked.format(context);
      Log.d(endTimeController.text);
    }
  }

  /// =========================
  /// PICK IMAGE
  /// =========================
  void pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFile.value = File(picked.path);
    }
  }

  /// =========================
  /// SUBMIT ANNOUNCEMENT
  /// =========================
  Future<void> submitAnnouncement() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        startDateController.text.isEmpty ||
        startTimeController.text.isEmpty ||
        endDateController.text.isEmpty ||
        endTimeController.text.isEmpty) {
      Utils.toast('Lengkapi semua field', snackType: SnackType.error);
      return;
    }

    if (isSubmitting.value) return; // extra guard

    isSubmitting.value = true;

    try {
      final startPeriod =
          '${startDateController.text} ${startTimeController.text}';
      final endPeriod = '${endDateController.text} ${endTimeController.text}';

      final request = AnnouncementRequest(
        announcement: titleController.text.trim(),
        description: descriptionController.text.trim(),
        startPeriod: startPeriod,
        endPeriod: endPeriod,
        areaProvinceId: AuthController.instance.auth?.userdata?.areaProvinceId,
        areaRegenciesId:
            AuthController.instance.auth?.userdata?.areaRegenciesId,
      );

      Log.d(request.toJson());

      final result = await announcementRepository.createAnnouncement(request);

      if (result.isSuccess) {
        Get.back(result: true); 
      } else {
        Utils.toast(result.message ?? 'Gagal membuat pengumuman',
            snackType: SnackType.error);
      }
    } catch (e, st) {
      Log.e("submitAnnouncement error: $e\n$st");
      Utils.toast('Terjadi kesalahan', snackType: SnackType.error);
    } finally {
      isSubmitting.value = false;
    }
  }
}
