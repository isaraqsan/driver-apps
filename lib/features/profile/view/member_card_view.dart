import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/constant.dart';
import 'package:gibas/features/profile/controller/member_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MemberCardView extends StatelessWidget {
  const MemberCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MemberCardController>(
      init: MemberCardController(),
      builder: (controller) {
        return BaseScaffold(
          title: 'Kartu Anggota',
          usePaddingHorizontal: false,
          contentMobile: _contentMobile(controller),
        );
      },
    );
  }

  Widget _contentMobile(MemberCardController controller) {
    return controller.obx(
      (state) => SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            if (state?.data != null && state!.data.isNotEmpty) ...[
              const Text(
                'Kartu Anggota Anda',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.textTitle,
                ),
              ),
              const SizedBox(height: 12),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  height: 450,
                  color: Colors.white,
                  child: SfPdfViewer.network(
                    '${Constant.baseApiUrl}${state.data}',
                    enableDoubleTapZooming: true,
                    canShowScrollHead: false,
                    canShowPaginationDialog: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: controller.downloadPdf,
                  icon: const Icon(Icons.download_rounded),
                  label: const Text(
                    'Download PDF',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorPalette.greenTheme,
                    foregroundColor: ColorPalette.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                ),
              ),
            ] else
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.picture_as_pdf, size: 60, color: Colors.grey),
                    SizedBox(height: 12),
                    Text('PDF tidak tersedia', style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
          ],
        ),
      ),
      onLoading: const Center(
        child: CircularProgressIndicator(color: ColorPalette.primary),
      ),
      onError: (error) => Center(child: Text('Gagal load PDF: $error')),
      onEmpty: const Center(child: Text('PDF tidak tersedia')),
    );
  }
}
