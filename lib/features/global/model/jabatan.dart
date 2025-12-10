import 'package:gibas/features/global/model/jenjang.dart';

class Jabatan {
  int? id;
  int? jenjangId;
  String? name;
  String? description;
  int? isTopLevel;
  int? status;
  int? createdBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  Jenjang? jenjang;

  Jabatan({
    this.id,
    this.jenjangId,
    this.name,
    this.description,
    this.isTopLevel,
    this.status,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
    this.jenjang,
  });

  factory Jabatan.fromJson(Map<String, dynamic> json) {
    return Jabatan(
      id: json['id'],
      jenjangId: json['jenjang_id'],
      name: json['name'],
      description: json['description'],
      isTopLevel: json['is_top_level'],
      status: json['status'],
      createdBy: json['created_by'],
      createdDate: json['created_date'],
      modifiedBy: json['modified_by'],
      modifiedDate: json['modified_date'],
      jenjang:
          json['jenjang'] != null ? Jenjang.fromJson(json['jenjang']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jenjang_id': jenjangId,
      'name': name,
      'description': description,
      'is_top_level': isTopLevel,
      'status': status,
      'created_by': createdBy,
      'created_date': createdDate,
      'modified_by': modifiedBy,
      'modified_date': modifiedDate,
      'jenjang': jenjang?.toJson(),
    };
  }
}
