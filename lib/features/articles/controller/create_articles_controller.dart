// File: create_articles_controller.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/features/global/repository/global_repository.dart';
import 'package:gibas/shared/widgets/overlay/overlay_controller.dart';
import 'package:image_picker/image_picker.dart';

class CreateArticlesController extends GetxController {
  final imageFile = Rx<File?>(null);
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final selectedCategory = ''.obs;
  late GlobalRepository globalRepository;

  final categories = ['Berita', 'Pengumuman', 'Edukasi'].obs;
  final isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Mendapatkan ID dari parameter route
    globalRepository = GlobalRepository();
  }

  void pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFile.value = File(picked.path);
    }
  }

  void submitArticle() async {
    if (imageFile.value == null) {
      Utils.toast('Gambar belum dipilih', snackType: SnackType.error);
      return;
    }

    OverlayController.to.showLoading();

    final result = await globalRepository.createArticle(
      categoryName: 'umum',
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      image: imageFile.value!,
    );

    OverlayController.to.hide();

    if (result.isSuccess) {
      Get.back(
          result: true); // Kembalikan nilai true agar halaman sebelumnya tahu
      // Utils.toast('Berita berhasil dikirim');
    } else {
      Utils.toast(
        result.message ?? 'Gagal mengirim artikel',
        snackType: SnackType.error,
      );
    }
  }
}
