import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:gibas/core/app/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:gibas/core/service/database_service.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/features/profile/model/card_response.dart';
import 'package:gibas/features/profile/model/users_request.dart';
import 'package:gibas/features/profile/repository/profile_repository.dart';
import 'package:gibas/shared/typography/typography_component.dart';
import 'package:gibas/shared/widgets/overlay/overlay_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberCardController extends GetxController
    with StateMixin<GenerateCardResponse> {
  late ProfileRepository profileRepository;
  late DatabaseService databaseService;

  late UsersRequest usersRequest;

  @override
  void onInit() {
    Log.i('testting');
    profileRepository = ProfileRepository();
    databaseService = Get.find<DatabaseService>();

    super.onInit();
  }

  @override
  void onReady() {
    onGetCard();
    super.onReady();
  }

  Future<void> onGetCard() async {
    OverlayController.to.showLoading();
    change(null, status: RxStatus.loading());
    final auth = AuthController.instance.auth?.userdata?.resourceUuid;
    usersRequest = UsersRequest(mode: 'card', users: [auth ?? '']);
    try {
      final result = await profileRepository.getCard(usersRequest);

      if (result.isSuccess && result.data != null) {
        change(result.data, status: RxStatus.success());
        OverlayController.to.hide();
      } else {
        // Kalau gagal, bisa update state error
        change(null,
            status: RxStatus.error(result.message ?? 'Gagal load profile'));
        OverlayController.to.hide();
      }
    } catch (e) {
      // Kalau ada exception
      change(null, status: RxStatus.error(e.toString()));
      OverlayController.to.hide();
    }
  }

  Future<void> onRefresh() async {
    await onGetCard();
  }

  Future<void> downloadPdf() async {
    final username = AuthController.instance.auth?.userdata?.username ?? 'file';
    final filename = '$username${DateTime.now().millisecondsSinceEpoch}.pdf';

    try {
      Directory dir;

      if (Platform.isAndroid) {
        dir = Directory('/storage/emulated/0/Download');
        if (!await dir.exists()) {
          dir = (await getExternalStorageDirectory())!;
        }
      } else if (Platform.isIOS) {
        dir = await getApplicationDocumentsDirectory();
      } else {
        throw UnsupportedError("Unsupported platform");
      }

      // Hapus semua task lama
      final tasks = await FlutterDownloader.loadTasks();
      if (tasks != null) {
        for (final task in tasks) {
          await FlutterDownloader.remove(
            taskId: task.taskId,
            shouldDeleteContent: true,
          );
        }
      }

      await FlutterDownloader.enqueue(
        url: '${Constant.baseApiUrl}${state?.data}',
        savedDir: dir.path,
        fileName: filename,
        openFileFromNotification: true, // iOS butuh ini
        showNotification: true, // biar kelihatan di Android
      );
    } catch (e) {
      Utils.toast('Error Gagal download PDF: $e', snackType: SnackType.error);
      Log.e(e, tag: 'ERROR DOWNLOAD');
    }
  }

  Future<void> openPdf() async {
    final filename = AuthController.instance.auth?.userdata?.username;
    try {
      // Download file dulu
      final dir = await getTemporaryDirectory(); // simpan di temp
      final filePath = '${dir.path}/$filename.pdf';

      await Dio().download('${Constant.baseApiUrl}${state?.data}', filePath);

      // Share file
      await Share.shareXFiles([XFile(filePath)],
          text: 'Berikut PDF kartu anggota saya');

      Get.snackbar('Sukses', 'PDF siap dibagikan');
    } catch (e) {
      Get.snackbar('Error', 'Gagal share PDF: $e');
    }
  }
}
