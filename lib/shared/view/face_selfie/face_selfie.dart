// import 'dart:async';
// import 'dart:io';
// import 'dart:math';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart' show Get, GetNavigation;
// import 'package:gibas/core/app/color_palette.dart';
// import 'package:gibas/core/app/dimens.dart';
// import 'package:gibas/shared/component/buttons.dart';
// import 'package:gibas/shared/component/component.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;

// class FaceCheckInScreen extends StatefulWidget {
//   const FaceCheckInScreen({super.key});

//   @override
//   State<FaceCheckInScreen> createState() => _FaceCheckInScreenState();
// }

// class _FaceCheckInScreenState extends State<FaceCheckInScreen> {
//   CameraController? _controller;
//   late Future<void> _initializeControllerFuture;
//   bool _isCapturing = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeCamera();
//   }

//   Future<void> _initializeCamera() async {
//     final cameras = await availableCameras();
//     final frontCamera = cameras.firstWhere(
//       (camera) => camera.lensDirection == CameraLensDirection.front,
//       orElse: () => cameras.first,
//     );

//     _controller = CameraController(
//       frontCamera,
//       ResolutionPreset.medium,
//     );

//     _initializeControllerFuture = _controller!.initialize();
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }

//   Future<String?> _takePicture() async {
//     if (_isCapturing || !_controller!.value.isInitialized) return null;

//     setState(() => _isCapturing = true);

//     try {
//       final Directory extDir = await getTemporaryDirectory();
//       final String dirPath = path.join(extDir.path, 'checkin_photos');
//       await Directory(dirPath).create(recursive: true);
//       final String filePath = path.join(
//         dirPath,
//         '${DateTime.now().millisecondsSinceEpoch}.jpg',
//       );

//       if (_controller!.value.isTakingPicture) return null;

//       final XFile picture = await _controller!.takePicture();
//       await picture.saveTo(filePath);

//       return filePath;
//     } catch (e) {
//       return null;
//     } finally {
//       setState(() => _isCapturing = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorPalette.white,
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Stack(
//               alignment: Alignment.center,
//               children: [
//                 CameraPreview(_controller!),
//                 _buildFaceOverlay(),
//                 _buildCaptureButton(),
//               ],
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildFaceOverlay() {
//     return CustomPaint(
//       painter: FaceOverlayPainter(),
//       child: Container(),
//     );
//   }

//   Widget _buildCaptureButton() {
//     return Positioned(
//       bottom: 50,
//       child: FloatingActionButton(
//         backgroundColor: Colors.white,
//         onPressed: () async {
//           final imagePath = await _takePicture();
//           if (imagePath != null) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => PreviewScreen(imagePath: imagePath),
//               ),
//             );
//           }
//         },
//         child: const Icon(Icons.camera_alt, color: Colors.black),
//       ),
//     );
//   }
// }

// class FaceOverlayPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = min(size.width, size.height) * 0.35;

//     final overlayPaint = Paint()
//       ..color = Colors.black.withValues(alpha: 0.5)
//       ..style = PaintingStyle.fill;

//     canvas.drawRect(
//       Rect.fromLTWH(0, 0, size.width, size.height),
//       overlayPaint,
//     );

//     canvas.drawPath(
//       Path.combine(
//         PathOperation.difference,
//         Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
//         Path()..addOval(Rect.fromCircle(center: center, radius: radius)),
//       ),
//       Paint()..color = Colors.black.withValues(alpha: 0.5),
//     );

//     final guidePaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0;

//     canvas.drawCircle(center, radius, guidePaint);

//     final textPainter = TextPainter(
//       text: const TextSpan(
//         text: 'Letakkan wajah Anda dalam lingkaran',
//         style: TextStyle(color: Colors.white, fontSize: 18),
//       ),
//       textDirection: TextDirection.ltr,
//     );

//     textPainter.layout();
//     textPainter.paint(
//       canvas,
//       Offset(center.dx - textPainter.width / 2, center.dy + radius + 20),
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

// class PreviewScreen extends StatelessWidget {
//   final String imagePath;

//   const PreviewScreen({super.key, required this.imagePath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: Component.appbar('Preview Foto'),
//       backgroundColor: ColorPalette.white,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Transform(
//                 alignment: Alignment.center,
//                 transform: Matrix4.rotationY(pi),
//                 child: Image.file(File(imagePath)),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Expanded(
//                     child: Buttons.outlineButton(
//                       title: 'Ambil Ulang',
//                       onPressed: () => Navigator.pop(context),
//                       fitWidth: true,
//                     ),
//                   ),
//                   Dimens.marginHorizontalSmall(),
//                   Expanded(
//                     child: Buttons.primaryButton(
//                       title: 'Simpan',
//                       onPressed: () {
//                         Get.back(result: imagePath);
//                         Get.back(result: imagePath);
//                       },
//                       fitWidth: true,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
