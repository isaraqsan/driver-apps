// area_model.dart

class SubDistrictResponse {
  final int total;
  final List<SubDistrict> values;

  SubDistrictResponse({
    required this.total,
    required this.values,
  });

  factory SubDistrictResponse.fromJson(Map<String, dynamic> json) {
    return SubDistrictResponse(
      total: json['total'] ?? 0,
      values: (json['values'] as List<dynamic>?)
              ?.map((e) => SubDistrict.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'values': values.map((e) => e.toJson()).toList(),
    };
  }
}

class SubDistrict {
  final int id;
  final int areaProvinceId;
  final int areaRegenciesId;
  final String name;

  SubDistrict({
    required this.id,
    required this.areaProvinceId,
    required this.areaRegenciesId,
    required this.name,
  });

  factory SubDistrict.fromJson(Map<String, dynamic> json) {
    return SubDistrict(
      id: json['id'] ?? 0,
      areaProvinceId: json['area_province_id'] ?? 0,
      areaRegenciesId: json['area_regencies_id'] ?? 0,
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'area_province_id': areaProvinceId,
      'area_regencies_id': areaRegenciesId,
      'name': name,
    };
  }
}
