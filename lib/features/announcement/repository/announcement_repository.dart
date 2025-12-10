import 'package:gibas/domain/base/repository.dart';
import 'package:gibas/features/announcement/model/announcement_request.dart';
import 'package:gibas/features/announcement/model/announcement_response.dart';

class AnnouncementRepository extends Repository {
  Future<DataResult<AnnouncementRequest>> createAnnouncement(
      AnnouncementRequest request) async {
    return await dioService.post(
      url: Endpoint.announcement,
      body: request.toJson(),
      loading: true,
      fromJsonT: (data) => AnnouncementRequest.fromJson(data),
    );
  }

  Future<DataResult<AnnouncementResponse>> getAnnouncement() async {
    return await dioService.get(
      url: '${Endpoint.announcement}/all-data',
      loading: true,
      fromJsonT: (data) => AnnouncementResponse.fromJson(data),
    );
  }
}
