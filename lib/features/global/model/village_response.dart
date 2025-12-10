class VillageResponse {
  int total;
  List<Village> values;

  VillageResponse({
    required this.total,
    required this.values,
  });

  factory VillageResponse.fromJson(Map<String, dynamic> json) {
    return VillageResponse(
      total: json['total'] ?? 0,
      values: (json['values'] as List<dynamic>? ?? [])
          .map((e) => Village.fromJson(e))
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

class Village {
  int id;
  int areaProvinceId;
  int areaRegenciesId;
  int areaSubdistrictId;
  String name;

  Village({
    required this.id,
    required this.areaProvinceId,
    required this.areaRegenciesId,
    required this.areaSubdistrictId,
    required this.name,
  });

  factory Village.fromJson(Map<String, dynamic> json) {
    return Village(
      id: json['id'],
      areaProvinceId: json['area_province_id'],
      areaRegenciesId: json['area_regencies_id'],
      areaSubdistrictId: json['area_subdistrict_id'],
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'area_province_id': areaProvinceId,
      'area_regencies_id': areaRegenciesId,
      'area_subdistrict_id': areaSubdistrictId,
      'name': name,
    };
  }
}
