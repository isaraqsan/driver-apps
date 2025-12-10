import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/features/announcement/controller/announcement_form_controller.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/_input_field.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:iconsax/iconsax.dart';

class AnnouncementFormView extends GetView<AnnouncementFormController> {
  const AnnouncementFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AnnouncementFormController(),
      builder: (controller) {
        return BaseScaffold(
          title: 'Buat Pengumuman',
          usePaddingHorizontal: false,
          contentMobile: _contentMobile(context, controller),
        );
      },
    );
  }

  Widget _contentMobile(
      BuildContext context, AnnouncementFormController controller) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          margin: Dimens.marginContentHorizontal10,
          decoration: Component.shadow(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Input Judul
              InputField(
                controller: controller.titleController,
                label: 'Judul',
                hint: 'Masukkan judul Pengumuman',
                isRequired: true,
              ),
              const SizedBox(height: 24),

              /// Input Deskripsi
              InputField(
                controller: controller.descriptionController,
                label: 'Deskripsi',
                hint: 'Tulis deskripsi lengkap pengumuman di sini...',
                maxLines: 10,
                minLines: 6,
                isRequired: true,
              ),
              const SizedBox(height: 24),

              /// Pilih Tanggal Mulai
              InputField(
                label: 'Tanggal Mulai',
                controller: controller.startDateController,
                hint: 'Pilih Tanggal Mulai',
                readOnly: true,
                onTap: () async => controller.pickStartDate(context),
              ),
              const SizedBox(height: 16),

              /// Pilih Jam Mulai
              InputField(
                label: 'Jam Mulai',
                controller: controller.startTimeController,
                hint: 'Pilih Jam Mulai',
                readOnly: true,
                onTap: () async => controller.pickStartTime(context),
              ),
              const SizedBox(height: 16),

              /// Pilih Tanggal Selesai
              InputField(
                label: 'Tanggal Selesai',
                controller: controller.endDateController,
                hint: 'Pilih Tanggal Selesai',
                readOnly: true,
                onTap: () async => controller.pickEndDate(context),
              ),
              const SizedBox(height: 16),

              /// Pilih Jam Selesai
              InputField(
                label: 'Jam Selesai',
                controller: controller.endTimeController,
                hint: 'Pilih Jam Selesai',
                readOnly: true,
                onTap: () async => controller.pickEndTime(context),
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 32),

              /// Tombol Submit
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: controller.isSubmitting.value
                        ? null
                        : controller.submitAnnouncement,
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
                          : "Terbitkan Pengumuman",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
