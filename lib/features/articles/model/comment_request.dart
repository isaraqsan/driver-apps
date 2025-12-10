class CommentRequest {
  final int id; // id eksternal (misal: id artikel)
  final int group; // kode grup komentar
  final int status; // status (1 = aktif, dll)
  final String comment; // isi komentar

  CommentRequest({
    required this.id,
    required this.group,
    required this.status,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group': group,
      'status': status,
      'comment': comment,
    };
  }

  factory CommentRequest.fromJson(Map<String, dynamic> json) {
    return CommentRequest(
      id: json['id'] ?? 0,
      group: json['group'] ?? 0,
      status: json['status'] ?? 0,
      comment: json['comment'] ?? '',
    );
  }
}
