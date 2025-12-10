class AnnouncementRequest {
  String announcement;
  String description;
  String startPeriod;
  String endPeriod;
  int? areaProvinceId;
  int? areaRegenciesId;

  AnnouncementRequest({
    required this.announcement,
    required this.description,
    required this.startPeriod,
    required this.endPeriod,
    this.areaProvinceId,
    this.areaRegenciesId,
  });

  factory AnnouncementRequest.fromJson(Map<String, dynamic> json) {
    return AnnouncementRequest(
      announcement: json['announcement'] ?? '',
      description: json['description'] ?? '',
      startPeriod: json['start_period'] ?? '',
      endPeriod: json['end_period'] ?? '',
      areaProvinceId: json['area_province_id'],
      areaRegenciesId: json['area_regencies_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'announcement': announcement,
      'description': description,
      'start_period': startPeriod,
      'end_period': endPeriod,
    };

    if (areaProvinceId != null) {
      data['area_province_id'] = areaProvinceId;
    }
    if (areaRegenciesId != null) {
      data['area_regencies_id'] = areaRegenciesId;
    }

    return data;
  }
}
