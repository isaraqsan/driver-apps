class Like {
  int? id;
  int? group;
  Like({this.id, this.group});

  Like.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    group = json['group'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'group': group,
      };
}
