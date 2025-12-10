class ArticleDetail {
  final int id;
  final String categoryName;
  final String title;
  final String slug;
  final String description;
  final String pathThumbnail;
  final String pathImage;
  final int status;
  final int counterView;
  final int counterShare;
  final int counterLike;
  final int counterComment;
  final bool like; // Diubah dari int ke bool
  final int createdBy;
  final String createdDate;
  final int? modifiedBy;
  final String? modifiedDate;
  final Author author;
  final Komunitas? komunitas;
  final Tema? tema;

  ArticleDetail({
    required this.id,
    required this.categoryName,
    required this.title,
    required this.slug,
    required this.description,
    required this.pathThumbnail,
    required this.pathImage,
    required this.status,
    required this.counterView,
    required this.counterShare,
    required this.counterLike,
    required this.counterComment,
    required this.like, // Diubah dari int ke bool
    required this.createdBy,
    required this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
    required this.author,
    this.komunitas,
    this.tema,
  });

  factory ArticleDetail.fromJson(Map<String, dynamic> json) {
    return ArticleDetail(
      id: json['id'],
      categoryName: json['category_name'] ?? '',
      title: json['title'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      pathThumbnail: json['path_thumbnail'] ?? '',
      pathImage: json['path_image'] ?? '',
      status: json['status'] ?? 0,
      counterView: json['counter_view'] ?? 0,
      counterShare: json['counter_share'] ?? 0,
      counterLike: json['counter_like'] ?? 0,
      counterComment: json['counter_comment'] ?? 0,
      like: json['like'] ?? false, // Diubah dari 0 ke false
      createdBy: json['created_by'] ?? 0,
      createdDate: json['created_date'] ?? '',
      modifiedBy: json['modified_by'],
      modifiedDate: json['modified_date'],
      author: Author.fromJson(json['author'] ?? {}),
      komunitas: json['komunitas'] != null
          ? Komunitas.fromJson(json['komunitas'])
          : null,
      tema: json['tema'] != null ? Tema.fromJson(json['tema']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_name': categoryName,
      'title': title,
      'slug': slug,
      'description': description,
      'path_thumbnail': pathThumbnail,
      'path_image': pathImage,
      'status': status,
      'counter_view': counterView,
      'counter_share': counterShare,
      'counter_like': counterLike,
      'counter_comment': counterComment,
      'like': like,
      'created_by': createdBy,
      'created_date': createdDate,
      'modified_by': modifiedBy,
      'modified_date': modifiedDate,
      'author': author.toJson(),
      'komunitas': komunitas?.toJson(),
      'tema': tema?.toJson(),
    };
  }
}

class Author {
  final String username;
  final String fullName;
  final String? imageFoto;
  final String province;
  final String regency;
  Author({
    required this.username,
    required this.fullName,
    this.imageFoto,
    required this.province,
    required this.regency,
  });
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      username: json['username'] ?? '',
      fullName: json['full_name'] ?? '',
      imageFoto: json['image_foto'],
      province: json['province'] ?? '',
      regency: json['regency'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'full_name': fullName,
      'image_foto': imageFoto,
      'province': province,
      'regency': regency,
    };
  }
}

class Komunitas {
  final int id;
  final String komunitasName;
  final int type;
  final String? iconImage;
  Komunitas({
    required this.id,
    required this.komunitasName,
    required this.type,
    this.iconImage,
  });
  factory Komunitas.fromJson(Map<String, dynamic> json) {
    return Komunitas(
      id: json['id'],
      komunitasName: json['komunitas_name'] ?? '',
      type: json['type'] ?? 0,
      iconImage: json['icon_image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'komunitas_name': komunitasName,
      'type': type,
      'icon_image': iconImage,
    };
  }
}

class Tema {
  final int id;
  final String temaName;
  final int type;
  final String? iconImage;
  Tema({
    required this.id,
    required this.temaName,
    required this.type,
    this.iconImage,
  });
  factory Tema.fromJson(Map<String, dynamic> json) {
    return Tema(
      id: json['id'],
      temaName: json['tema_name'] ?? '',
      type: json['type'] ?? 0,
      iconImage: json['icon_image'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tema_name': temaName,
      'type': type,
      'icon_image': iconImage,
    };
  }
}
