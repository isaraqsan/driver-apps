import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gibas/core/app/app_config.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/core/service/image_service.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/shared/typography/_text_component.dart';
import 'package:gibas/shared/widgets/state_widget.dart';

enum PhotoPickerState { picker, file, url, loading, error }

class PhotoPicker extends StatefulWidget {
  final ImageSource? imageSource;
  final CameraDevice cameraDevice;
  final String? path;
  final ValueChanged<File?> onChanged;
  final double? height;
  final double? width;
  final String? cacheKey;
  final String? label;

  const PhotoPicker({
    super.key,
    this.imageSource,
    this.cameraDevice = CameraDevice.rear,
    this.path,
    this.cacheKey,
    required this.onChanged,
    this.height,
    this.width,
    this.label,
  });

  @override
  State<PhotoPicker> createState() => _PhotoPickerState();
}

class _PhotoPickerState extends State<PhotoPicker> {
  File? file;
  PhotoPickerState photoPickerState = PhotoPickerState.picker;

  @override
  void initState() {
    checkPath();
    super.initState();
  }

  void checkPath() {
    if ((widget.path?.contains(AppConfig.https) ?? false) || (widget.path?.contains(AppConfig.http) ?? false)) {
      photoPickerState = PhotoPickerState.url;
    } else if (widget.path?.isNotEmpty ?? false) {
      final potentialFile = File(widget.path!);
      if (potentialFile.existsSync()) {
        file = potentialFile;
        photoPickerState = PhotoPickerState.file;
      } else {
        photoPickerState = PhotoPickerState.error;
        Log.v('File ${widget.path} Not Found', tag: runtimeType.toString());
        // final CustomerImageRepository customerImageRepository = CustomerImageRepository();
        // customerImageRepository.removeByPath(widget.path!);
      }
    } else {
      photoPickerState = PhotoPickerState.picker;
    }
    Log.v('Photo Picker State => $photoPickerState', tag: runtimeType.toString());
    setState(() {});
  }

  Future<void> onPickImage() async {
    if (photoPickerState == PhotoPickerState.picker) {
      File? image;
      if (widget.imageSource == null) {
        image = await ImageService.imageWithOption();
      } else {
        image = await ImageService.image(
          source: widget.imageSource!,
          cameraDevice: widget.cameraDevice,
          markAddress: true,
        );
      }
      if (image != null) {
        file = File(image.path);
        photoPickerState = PhotoPickerState.file;
        widget.onChanged(file);
        setState(() {});
      }
    }
  }

  void onRemoveImage() {
    // * Try delete file
    try {
      Log.v('Delete Image ${file?.path}', tag: runtimeType.toString());
      if (file?.existsSync() ?? false) {
        file?.delete();
        Log.v('Delete Image ${file?.path} Success', tag: runtimeType.toString());
      }
    } catch (e) {
      Log.e('Delete Image ${file?.path} Error => $e', tag: runtimeType.toString());
    }
    setState(() {
      photoPickerState = PhotoPickerState.picker;
      file = null;
    });
    widget.onChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) TextComponent.textTitle(widget.label ?? 'Foto', colors: ColorPalette.white),
        if (widget.label != null) Dimens.marginVerticalMedium(),
        InkWell(
          onTap: onPickImage,
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: Dimens.padding10,
            decoration: BoxDecoration(
                color: ColorPalette.blackText2,
                borderRadius: BorderRadius.circular(Dimens.radiusSmall),
                border: Border.all(
                  color: ColorPalette.grey,
                )),
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(Dimens.radiusSmall),
                    child: content(),
                  ),
                  Visibility(
                    visible: photoPickerState != PhotoPickerState.picker,
                    child: Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: onRemoveImage,
                        child: Container(
                          padding: Dimens.padding5,
                          decoration: BoxDecoration(
                            color: ColorPalette.white2,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.1),
                                spreadRadius: 3,
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Icon(
                            CupertinoIcons.delete,
                            size: 20,
                            color: ColorPalette.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget content() {
    switch (photoPickerState) {
      case PhotoPickerState.picker:
        return SizedBox(
          height: widget.height ?? 100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.add_circled_solid,
                color: ColorPalette.white,
              ),
              const SizedBox(
                height: Dimens.value10,
              ),
              TextComponent.textBody('Tambah Foto', colors: ColorPalette.white),
            ],
          ),
        );
      case PhotoPickerState.file:
        return Image.file(
          file!,
          fit: BoxFit.cover,
          width: widget.width,
          height: widget.height,
        );
      case PhotoPickerState.url:
        return Image.network(
          widget.path!,
          fit: BoxFit.cover,
          width: widget.width,
          height: widget.height,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return const CircularProgressIndicator();
            }
          },
        );
      case PhotoPickerState.error:
        return SizedBox(
          height: widget.height ?? 100,
          child: const Icon(Icons.broken_image),
        );
      case PhotoPickerState.loading:
        return StateWidget.loadingWhite();
    }
  }
}
