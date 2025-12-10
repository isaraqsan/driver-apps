import 'package:gibas/features/global/model/article.dart';

class ArticleResponse {
  final int total;
  final List<Article> values;

  ArticleResponse({
    required this.total,
    required this.values,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) {
    return ArticleResponse(
      total: json['total'] ?? 0,
      values: (json['values'] as List<dynamic>)
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'values': values.map((e) => e.toJson()).toList(),
    };
  }
}
