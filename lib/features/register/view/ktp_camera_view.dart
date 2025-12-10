import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gibas/features/register/controller/register_controller.dart';

class KtpCameraView extends StatelessWidget {
  const KtpCameraView({super.key});

  Future<void> _openCamera() async {
    final controller = Get.find<RegisterController>();
    final ImagePicker picker = ImagePicker();

    Log.i('Opening camera...', tag: 'KTP');
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 90,
      );
      Log.i('Camera result: $pickedFile', tag: 'KTP');

      if (pickedFile != null) {
        await controller.processKtpImage(pickedFile.path);
      } else {
        Log.i('User cancelled camera capture', tag: 'KTP');
      }
    } catch (e, st) {
      Log.e('Failed to open camera: $e\n$st', tag: 'KTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    Log.i('KtpCameraView build dipanggil', tag: 'KTP');
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Konten utama
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.camera_alt, color: Colors.white, size: 64),
                const SizedBox(height: 16),
                const Text(
                  "Posisikan KTP di dalam frame lalu ambil foto",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Log.i('Tombol Ambil Foto ditekan', tag: 'KTP');
                    _openCamera();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text("Ambil Foto KTP"),
                ),
              ],
            ),
          ),

          // Overlay frame KTP, kasih IgnorePointer biar tombol tetap bisa diklik
          IgnorePointer(
            child: Align(
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: 85.6 / 53.98,
                child: Container(
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
