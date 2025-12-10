class AnnouncementResponse {
  final int id;
  final String announcement;
  final DateTime startPeriod;
  final DateTime endPeriod;
  final String description;
  final int status;
  final int areaProvinceId;
  final int areaRegenciesId;
  final int? createdBy;
  final DateTime? createdDate;
  final int? modifiedBy;
  final DateTime? modifiedDate;
  final Province? province;
  final Regency? regency;

  AnnouncementResponse({
    required this.id,
    required this.announcement,
    required this.startPeriod,
    required this.endPeriod,
    required this.description,
    required this.status,
    required this.areaProvinceId,
    required this.areaRegenciesId,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
    this.province,
    this.regency,
  });

  factory AnnouncementResponse.fromJson(Map<String, dynamic> json) {
    return AnnouncementResponse(
      id: json['id'],
      announcement: json['announcement'] ?? '',
      startPeriod: DateTime.parse(json['start_period']),
      endPeriod: DateTime.parse(json['end_period']),
      description: json['description'] ?? '',
      status: json['status'] ?? 0,
      areaProvinceId: json['area_province_id'] ?? 0,
      areaRegenciesId: json['area_regencies_id'] ?? 0,
      createdBy: json['created_by'],
      createdDate: json['created_date'] != null
          ? DateTime.tryParse(json['created_date'])
          : null,
      modifiedBy: json['modified_by'],
      modifiedDate: json['modified_date'] != null
          ? DateTime.tryParse(json['modified_date'])
          : null,
      province:
          json['province'] != null ? Province.fromJson(json['province']) : null,
      regency:
          json['regency'] != null ? Regency.fromJson(json['regency']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "announcement": announcement,
      "start_period": startPeriod.toIso8601String(),
      "end_period": endPeriod.toIso8601String(),
      "description": description,
      "status": status,
      "area_province_id": areaProvinceId,
      "area_regencies_id": areaRegenciesId,
      "created_by": createdBy,
      "created_date": createdDate?.toIso8601String(),
      "modified_by": modifiedBy,
      "modified_date": modifiedDate?.toIso8601String(),
      "province": province?.toJson(),
      "regency": regency?.toJson(),
    };
  }
}

class Province {
  final int id;
  final String name;

  Province({
    required this.id,
    required this.name,
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Regency {
  final int id;
  final String name;
  final int areaProvinceId;

  Regency({
    required this.id,
    required this.name,
    required this.areaProvinceId,
  });

  factory Regency.fromJson(Map<String, dynamic> json) {
    return Regency(
      id: json['id'],
      name: json['name'] ?? '',
      areaProvinceId: json['area_province_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "area_province_id": areaProvinceId,
      };
}
