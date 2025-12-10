import 'package:dio/dio.dart' show DioException;
import 'package:gibas/core/app/constant/response_status.dart';
import 'package:gibas/core/app/controller/auth_controller.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/core/utils/utils.dart';
import 'package:gibas/domain/models/data_result.dart';
import 'package:get/get.dart';
import 'package:gibas/shared/utils/bottomsheet_helper.dart';
import 'package:sentry_flutter/sentry_flutter.dart' show SentryEvent;

class ErrorHandling {
  static void errorApi(DataResult dataResult) {
    if (Get.isDialogOpen! || Get.isBottomSheetOpen!) return;
    switch (dataResult.status) {
      case ResponseStatus.failed:
      case ResponseStatus.internalServerError:
        BottomsheetHelper.error(message: dataResult.message);
        break;
      case ResponseStatus.unauthorized:
        final AuthController authController = Get.find<AuthController>();
        authController.onLogout();
        Utils.toast(dataResult.message, snackType: SnackType.error);
        break;
      default:
        BottomsheetHelper.error(message: dataResult.message);
        break;
    }
  }

  static Future<SentryEvent?>? beforeSendEvent(SentryEvent event, dynamic hint) {
    Log.e(event.throwable.toString(), tag: 'SENTRY');

    if (event.throwable is DioException) {
      final dioError = event.throwable as DioException;
      if (_isServerError(dioError)) {
        return null;
      }
    }

    Log.e('Exception Send to Sentry', tag: 'SENTRY');
    return null;
  }

  static bool _isServerError(DioException dioError) {
    return dioError.response?.statusCode != null && dioError.response!.statusCode! >= 500;
  }

  static Map<String, dynamic> defaultError() {
    return {
      'status': ResponseStatus.internalServerError,
      'message': 'Terjadi Kesalahan',
    };
  }
}
