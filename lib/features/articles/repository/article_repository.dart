import 'package:gibas/domain/base/repository.dart';
import 'package:gibas/domain/models/base_params.dart';
import 'package:gibas/features/articles/model/article_response.dart';
import 'package:gibas/features/articles/model/comment_request.dart';

class ArticleRepository extends Repository {
  Future<DataResult<CommentData>> commentList(BaseParams params) async {
    return await dioService.get(
      url: Endpoint.comment,
      param: params.toJson(),
      fromJsonT: (data) => CommentData.fromJson(data),
    );
  }

  Future<DataResult> commentCreate(CommentRequest body) async {
    return await dioService.post(
      url: Endpoint.commentCreate,
      body: body.toJson(),
    );
  }
}
