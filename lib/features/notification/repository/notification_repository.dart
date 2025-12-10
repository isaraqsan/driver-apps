import 'package:gibas/domain/base/repository.dart';
import 'package:gibas/domain/models/base_params.dart';
import 'package:gibas/features/notification/model/notification_model.dart';

class NotificationRepository extends Repository {
  Future<DataResult<NotificationResponse>> listNotification({
    BaseParams? params,
  }) async {
    final url = Endpoint.notification;

    return await dioService.get(
      url: url,
      param: params?.toJson(),
      fromJsonT: (data) => NotificationResponse.fromJson(data),
    );
  }
}
