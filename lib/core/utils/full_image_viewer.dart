import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FullImageViewer extends StatelessWidget {
  final String imageUrl;

  const FullImageViewer({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              color: Colors.black.withOpacity(0.9),
              child: InteractiveViewer(
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.broken_image, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 32,
            right: 16,
            child: IconButton(
              icon: const Icon(Iconsax.close_circle,
                  color: Colors.white, size: 28),
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }
}
