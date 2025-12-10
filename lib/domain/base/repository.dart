import 'package:gibas/core/service/dio_service.dart';
import 'package:get/get.dart' show Get, Inst;

export 'package:gibas/core/app/endpoint.dart';
export 'package:gibas/domain/models/data_result.dart';

class Repository {
  DioService dioService = Get.find<DioService>();
}
