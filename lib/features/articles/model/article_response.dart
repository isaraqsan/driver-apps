class CommentResponse {
  final CommentData? data;

  CommentResponse({this.data});

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
      data: json['values'] != null ? CommentData.fromJson(json['values']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'values': data?.toJson(),
    };
  }
}

class CommentData {
  final int? total;
  final List<Comment>? values;

  CommentData({this.total, this.values});

  factory CommentData.fromJson(Map<String, dynamic> json) {
    return CommentData(
      total: json['total'],
      values: (json['values'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'values': values?.map((e) => e.toJson()).toList(),
    };
  }
}

class Comment {
  final int? id;
  final int? idExternal;
  final int? groupComment;
  final String? comment;
  final int? createdBy;
  final DateTime? createdDate;
  final Author? author;
  final int? counterComment;
  final List<Comment>? replyComment; // nested reply, recursive

  Comment({
    this.id,
    this.idExternal,
    this.groupComment,
    this.comment,
    this.createdBy,
    this.createdDate,
    this.author,
    this.counterComment,
    this.replyComment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      idExternal: json['id_external'],
      groupComment: json['group_comment'],
      comment: json['comment'],
      createdBy: json['created_by'],
      createdDate: json['created_date'] != null
          ? DateTime.parse(json['created_date'])
          : null,
      author: json['author'] != null ? Author.fromJson(json['author']) : null,
      counterComment: json['counter_comment'],
      replyComment: (json['reply_comment'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_external': idExternal,
      'group_comment': groupComment,
      'comment': comment,
      'created_by': createdBy,
      'created_date': createdDate?.toIso8601String(),
      'author': author?.toJson(),
      'counter_comment': counterComment,
      'reply_comment': replyComment?.map((e) => e.toJson()).toList(),
    };
  }
}

class Author {
  final String? username;
  final String? fullName;
  final String? imageFoto;

  Author({this.username, this.fullName, this.imageFoto});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      username: json['username'],
      fullName: json['full_name'],
      imageFoto: json['image_foto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'full_name': fullName,
      'image_foto': imageFoto,
    };
  }
}
