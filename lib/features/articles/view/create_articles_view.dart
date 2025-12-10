import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/constant.dart';
import 'package:gibas/core/utils/full_image_viewer.dart';
import 'package:gibas/domain/usecase/textfield_validator.dart';
import 'package:gibas/features/articles/controller/articles_detail_controller.dart';
import 'package:gibas/features/articles/controller/create_articles_controller.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/typography/_input_field.dart';
import 'package:gibas/shared/widgets/state_widget.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class CreateArticlesView extends GetView<CreateArticlesController> {
  const CreateArticlesView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: CreateArticlesController(),
      builder: (controller) {
        return BaseScaffold(
          title: 'Buat Berita',
          usePaddingHorizontal: false,
          contentMobile: _contentMobile(context),
        );
      },
    );
  }

  Widget _contentMobile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upload Gambar
            GestureDetector(
              onTap: () => controller.pickImage(),
              child: Obx(() {
                final image = controller.imageFile.value;
                return Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                    image: image != null
                        ? DecorationImage(
                            image: FileImage(image),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: image == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Iconsax.gallery_add,
                                size: 40, color: Colors.white54),
                            const SizedBox(height: 8),
                            Text(
                              "Pilih Gambar",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 14,
                              ),
                            )
                          ],
                        )
                      : null,
                );
              }),
            ),
            const SizedBox(height: 24),

            // Input Judul
            InputField(
              controller: controller.titleController,
              label: 'Judul',
              hint: 'Masukkan judul',
              isRequired: true,
            ),
            const SizedBox(height: 24),

            // Deskripsi Panjang
            InputField(
              controller: controller.descriptionController,
              label: 'Deskripsi',
              hint: 'Tulis deskripsi lengkap artikel di sini...',
              maxLines: 10,
              minLines: 6,
              isRequired: true,
            ),

            const SizedBox(height: 32),

            // Tombol Submit
            Obx(() {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPalette.secondary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: controller.isSubmitting.value
                      ? null
                      : () => controller.submitArticle(),
                  icon: controller.isSubmitting.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Iconsax.send_2, color: Colors.white),
                  label: Text(
                    controller.isSubmitting.value
                        ? "Mengirim..."
                        : "Terbitkan Artikel",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
