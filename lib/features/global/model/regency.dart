class Regency {
  int? id;
  String? name;
  int? areaProvinceId;

  Regency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    areaProvinceId = json['area_province_id'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'area_province_id': areaProvinceId,
      };
}
