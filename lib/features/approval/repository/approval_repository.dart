import 'dart:io';

import 'package:gibas/domain/base/repository.dart';
import 'package:gibas/features/global/model/like.dart';
import 'package:gibas/features/global/model/resource_response.dart';

class ApprovalRepository extends Repository {
  Future<DataResult<ResourceResponse>> getMember({
    required int page,
    int perPage = 10,
    String? q,
    String? type,
  }) async {
    final url = Endpoint.listApproval;

    return await dioService.get(
      url: url,
      param: {
        'page': page,
        'perPage': perPage,
      },
      fromJsonT: (data) => ResourceResponse.fromJson(data),
    );
  }

  Future<DataResult<void>> createArticle({
    required String categoryName,
    required String title,
    required String description,
    required File image,
  }) async {
    final formData = {
      'category_name': categoryName,
      'title': title,
      'description': description,
      'image': await dioService.multipartFile(image),
    };

    return await dioService.postMultipart(
      url: Endpoint.articles, // should be 'forum/article'
      data: formData,
    );
  }

  Future<DataResult> like(Like body) async {
    return await dioService.post(
      url: Endpoint.likeArticle,
      body: body.toJson(),
    );
  }
}
