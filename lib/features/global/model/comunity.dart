class Comunity {
  int? id;
  String? komunitasName;
  int? type;
  String? iconImage;

  Comunity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    komunitasName = json['komunitas_name'];
    type = json['type'];
    iconImage = json['icon_image'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'komunitas_name': komunitasName,
        'type': type,
        'icon_image': iconImage,
      };
}
