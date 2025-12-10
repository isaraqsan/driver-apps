import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gibas/core/app/app_config.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/shared/widgets/state_widget.dart';

enum KenvueImageType { file, url, loading, error }

class KenvueImage extends StatefulWidget {
  final String? path;
  final double? height;
  final double? width;
  final String? cacheKey;
  final String? label;

  const KenvueImage({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.cacheKey,
    this.label,
  });

  @override
  State<KenvueImage> createState() => _KenvueImageState();
}

class _KenvueImageState extends State<KenvueImage> {
  late KenvueImageType _type;
  File? _file;

  @override
  void initState() {
    super.initState();
    _resolveImageType();
  }

  void _resolveImageType() {
    final path = widget.path;
    _type = KenvueImageType.error;

    if (path == null || path.isEmpty) return;

    if (path.contains(AppConfig.https) || path.contains(AppConfig.http)) {
      _type = KenvueImageType.url;
    } else {
      final file = File(path);
      if (file.existsSync()) {
        _type = KenvueImageType.file;
        _file = file;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Dimens.radiusSmall),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    switch (_type) {
      case KenvueImageType.file:
        return Image.file(
          _file!,
          fit: BoxFit.cover,
          width: widget.width,
          height: widget.height,
        );

      case KenvueImageType.url:
        return Image.network(
          widget.path!,
          fit: BoxFit.cover,
          width: widget.width,
          height: widget.height,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return _errorWidget();
          },
        );

      case KenvueImageType.loading:
        return StateWidget.loadingWhite();

      case KenvueImageType.error:
      return _errorWidget();
    }
  }

  Widget _errorWidget() {
    return SizedBox(
      height: widget.height ?? 100,
      width: widget.width ?? 100,
      child: const Icon(Icons.broken_image),
    );
  }
}
