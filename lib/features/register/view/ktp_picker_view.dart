import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class KtpImagePickerView extends StatefulWidget {
  const KtpImagePickerView({super.key});

  @override
  State<KtpImagePickerView> createState() => _KtpImagePickerViewState();
}

class _KtpImagePickerViewState extends State<KtpImagePickerView> {
  XFile? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (image != null) {
      setState(() => _pickedImage = image);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Background hint
            Align(
              alignment: Alignment.center,
              child: AspectRatio(
                aspectRatio: 85.6 / 53.98, // ukuran KTP
                child: Container(
                  margin: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Posisikan KTP di dalam kotak",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),

            // Ambil foto
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: _pickImage,
                  child: const Icon(Icons.camera_alt, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
