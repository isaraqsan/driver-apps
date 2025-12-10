class Jenjang {
  final int id;
  final String code;
  final String name;
  final String description;
  final String level;
  final int status;
  final String? createdBy;
  final String? createdDate;
  final String? modifiedBy;
  final String? modifiedDate;

  Jenjang({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.level,
    required this.status,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
  });

  factory Jenjang.fromJson(Map<String, dynamic> json) {
    return Jenjang(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      level: json['level'] ?? '',
      status: json['status'] ?? 0,
      createdBy: json['created_by'],
      createdDate: json['created_date'],
      modifiedBy: json['modified_by'],
      modifiedDate: json['modified_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'level': level,
      'status': status,
      'created_by': createdBy,
      'created_date': createdDate,
      'modified_by': modifiedBy,
      'modified_date': modifiedDate,
    };
  }
}
