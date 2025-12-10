import 'package:gibas/core/app/constant/jabatan_level.dart';
import 'package:gibas/features/global/model/jabatan.dart';
import 'package:gibas/features/global/model/jenjang.dart';
import 'package:gibas/features/global/model/province.dart';
import 'package:gibas/features/global/model/regency.dart';
import 'package:gibas/features/global/model/sub_district_response.dart';
import 'package:gibas/features/global/model/village_response.dart';

class ResourceResponse {
  final int total;
  final List<Resource> values;

  ResourceResponse({
    required this.total,
    required this.values,
  });

  factory ResourceResponse.fromJson(Map<String, dynamic> json) {
    return ResourceResponse(
      total: json['total'] ?? 0,
      values: (json['values'] as List<dynamic>)
          .map((e) => Resource.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'total': total,
        'values': values.map((e) => e.toJson()).toList(),
      };
}

class Resource {
  final int resourceId;
  final String resourceUuid;
  final int roleId;
  final String username;
  final String email;
  final String fullName;
  final String placeOfBirth;
  final String dateOfBirth;
  final String telepon;
  final String? imageFoto;
  final String status;
  final int komunitasId;
  final int? totalLogin;
  final int areaProvinceId;
  final int areaRegenciesId;
  int? areaSubdistrictsId;
  int? areaVillagesId;
  final int createdBy;
  final String createdDate;
  final int? modifiedBy;
  final String? modifiedDate;
  final String? pendidikan;
  final Role role;
  final Province province;
  final Regency regency;
  Village? village;
  SubDistrict? subDistrict;
  final String? statusPerkawinan;
  final int? jumlahTanggungan;
  JabatanLevel? jabatanLevel;
  Jabatan? jabatan;
  Jenjang? jenjang;
  String? fotoSelfy;
  String? fotoKtp;
  String? pekerjaan;
  String? confirmHash;
  String? agama;
  String? nomorRegistrasi;
  String? alamat;

  // final dynamic komunitas;

  Resource(
      {required this.resourceId,
      required this.resourceUuid,
      required this.roleId,
      required this.username,
      required this.email,
      required this.fullName,
      required this.placeOfBirth,
      required this.dateOfBirth,
      required this.telepon,
      required this.imageFoto,
      required this.status,
      required this.komunitasId,
      required this.totalLogin,
      required this.areaProvinceId,
      required this.areaRegenciesId,
      required this.createdBy,
      required this.createdDate,
      required this.modifiedBy,
      required this.modifiedDate,
      required this.role,
      required this.province,
      required this.regency,
      required this.pendidikan,
      required this.statusPerkawinan,
      this.jumlahTanggungan,
      this.jabatanLevel,
      this.jabatan,
      this.jenjang,
      this.fotoSelfy,
      this.fotoKtp,
      this.pekerjaan,
      this.confirmHash,
      this.areaSubdistrictsId,
      this.areaVillagesId,
      this.village,
      this.subDistrict,
      this.agama,
      this.alamat,
      this.nomorRegistrasi

      // required this.komunitas,
      });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      resourceId: json['resource_id'] ?? 0,
      resourceUuid: json['resource_uuid'] ?? '',
      roleId: json['role_id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      statusPerkawinan: json['status_perkawinan'] ?? '',
      jumlahTanggungan: json['jumlah_tanggungan'],
      pendidikan: json['pendidikan'] ?? '',
      fullName: json['full_name'] ?? '',
      placeOfBirth: json['place_of_birth'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      telepon: json['telepon'] ?? '',
      imageFoto: json['image_foto'],
      status: json['status'] ?? '',
      komunitasId: json['komunitas_id'] ?? 0,
      totalLogin: json['total_login'],
      areaProvinceId: json['area_province_id'] ?? 0,
      areaRegenciesId: json['area_regencies_id'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      createdDate: json['created_date'] ?? '',
      modifiedBy: json['modified_by'],
      modifiedDate: json['modified_date'],
      confirmHash: json['confirm_hash'],
      alamat: json['alamat'],
      agama: json['agama'],
      nomorRegistrasi: json['nomor_registrasi'],
      jabatanLevel: JabatanLevel.fromCode(json['jabatan_level']),
      jabatan:
          json['jabatan'] != null ? Jabatan.fromJson(json['jabatan']) : null,
      jenjang:
          json['jenjang'] != null ? Jenjang.fromJson(json['jenjang']) : null,
      role: Role.fromJson(json['role'] ?? {}),
      province: Province.fromJson(json['province'] ?? {}),
      regency: Regency.fromJson(json['regency'] ?? {}),
      fotoSelfy: json['foto_selfy'],
      fotoKtp: json['foto_ktp'],
      pekerjaan: json['pekerjaan'] ?? '',
      areaSubdistrictsId: json['area_subdistrict_id'],
      areaVillagesId: json['area_village_id'],
      village:
          json['village'] != null ? Village.fromJson(json['village']) : null,
      subDistrict: json['sub_district'] != null
          ? SubDistrict.fromJson(json['sub_district'])
          : null,

      // komunitas: json['komunitas'],
    );
  }

  Map<String, dynamic> toJson() => {
        'resource_id': resourceId,
        'resource_uuid': resourceUuid,
        'role_id': roleId,
        'username': username,
        'email': email,
        'status_perkawinan': statusPerkawinan,
        'jumlah_tanggungan': jumlahTanggungan,
        'pendidikan': pendidikan,
        'full_name': fullName,
        'place_of_birth': placeOfBirth,
        'date_of_birth': dateOfBirth,
        'telepon': telepon,
        'image_foto': imageFoto,
        'status': status,
        'komunitas_id': komunitasId,
        'confirm_hash': confirmHash,
        'total_login': totalLogin,
        'area_province_id': areaProvinceId,
        'area_regencies_id': areaRegenciesId,
        'created_by': createdBy,
        'created_date': createdDate,
        'modified_by': modifiedBy,
        'modified_date': modifiedDate,
        'role': role.toJson(),
        'province': province.toJson(),
        'regency': regency.toJson(),
        'jabatan_level': jabatanLevel?.code,
        'jabatan': jabatan?.toJson(),
        'jenjang': jenjang?.toJson(),
        'foto_selfy': fotoSelfy,
        'foto_ktp': fotoKtp,
        'pekerjaan': pekerjaan,
        'agama': agama,
        'alamat': alamat,
        'nomor_registrasi': nomorRegistrasi,
        'area_subdistrict_id': areaSubdistrictsId,
        'area_village_id': areaVillagesId,
        'village': village?.toJson(),
        'sub_district': subDistrict?.toJson(),
        // 'komunitas': komunitas,
      };
}

class Role {
  final int roleId;
  final String roleName;
  final int status;

  Role({
    required this.roleId,
    required this.roleName,
    required this.status,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      roleId: json['role_id'] ?? 0,
      roleName: json['role_name'] ?? '',
      status: json['status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'role_id': roleId,
        'role_name': roleName,
        'status': status,
      };
}
