import 'package:gibas/core/app/constant/jabatan_level.dart';
import 'package:gibas/features/auth/model/role_auth.dart';
import 'package:gibas/features/global/model/comunity.dart';
import 'package:gibas/features/global/model/jabatan.dart';
import 'package:gibas/features/global/model/province.dart';
import 'package:gibas/features/global/model/regency.dart';
import 'package:gibas/features/global/model/jenjang.dart';
import 'package:gibas/features/global/model/sub_district_response.dart';
import 'package:gibas/features/global/model/village_response.dart';

class Auth {
  UserData? userdata;

  Auth({this.userdata});

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        userdata: json['userdata'] != null
            ? UserData.fromJson(json['userdata'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'userdata': userdata?.toJson(),
      };
}

class UserData {
  int? resourceId;
  String? resourceUuid;
  int? roleId;
  String? username;
  String? email;
  String? fullName;
  String? placeOfBirth;
  String? dateOfBirth;
  String? telepon;
  String? imageFoto;
  String? status;
  int? komunitasId;
  int? totalLogin;

  int? jenjangId;
  int? jabatanId;

  int? areaProvinceId;
  int? areaRegenciesId;
  int? areaSubdistrictId;
  int? areaVillageId;

  String? statusPerkawinan;
  String? pendidikan;
  String? pekerjaan;
  int? jumlahTanggungan;

  String? fotoSelfy;
  String? fotoKtp;

  int? createdBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;

  RoleAuth? role;
  Province? province;
  Regency? regency;
  SubDistrict? subdistrict;
  Village? village;
  Comunity? komunitas;
  Jenjang? jenjang;
  Jabatan? jabatan;
  JabatanLevel? jabatanLevel;

  UserData({
    this.resourceId,
    this.resourceUuid,
    this.roleId,
    this.username,
    this.email,
    this.fullName,
    this.placeOfBirth,
    this.dateOfBirth,
    this.telepon,
    this.imageFoto,
    this.status,
    this.komunitasId,
    this.totalLogin,
    this.jenjangId,
    this.jabatanId,
    this.areaProvinceId,
    this.areaRegenciesId,
    this.areaSubdistrictId,
    this.areaVillageId,
    this.statusPerkawinan,
    this.pendidikan,
    this.pekerjaan,
    this.jumlahTanggungan,
    this.fotoSelfy,
    this.fotoKtp,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
    this.role,
    this.province,
    this.regency,
    this.subdistrict,
    this.village,
    this.komunitas,
    this.jenjang,
    this.jabatan,
    this.jabatanLevel = JabatanLevel.unknown, // default
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        resourceId: json['resource_id'],
        resourceUuid: json['resource_uuid'],
        roleId: json['role_id'],
        username: json['username'],
        email: json['email'],
        fullName: json['full_name'],
        placeOfBirth: json['place_of_birth'],
        dateOfBirth: json['date_of_birth'],
        telepon: json['telepon'],
        imageFoto: json['image_foto'],
        status: json['status'],
        komunitasId: json['komunitas_id'],
        totalLogin: json['total_login'],
        jenjangId: json['jenjang_id'],
        jabatanId: json['jabatan_id'],
        areaProvinceId: json['area_province_id'],
        areaRegenciesId: json['area_regencies_id'],
        areaSubdistrictId: json['area_subdistrict_id'],
        areaVillageId: json['area_village_id'],
        statusPerkawinan: json['status_perkawinan'],
        pendidikan: json['pendidikan'],
        pekerjaan: json['pekerjaan'],
        jumlahTanggungan: json['jumlah_tanggungan'],
        fotoSelfy: json['foto_selfy'],
        fotoKtp: json['foto_ktp'],
        createdBy: json['created_by'],
        createdDate: json['created_date'],
        modifiedBy: json['modified_by'],
        modifiedDate: json['modified_date'],
        jabatanLevel: JabatanLevel.fromCode(json['jabatan_level']),
        role: json['role'] != null ? RoleAuth.fromJson(json['role']) : null,
        province: json['province'] != null
            ? Province.fromJson(json['province'])
            : null,
        regency:
            json['regency'] != null ? Regency.fromJson(json['regency']) : null,
        subdistrict: json['subdistrict'] != null
            ? SubDistrict.fromJson(json['subdistrict'])
            : null,
        village:
            json['village'] != null ? Village.fromJson(json['village']) : null,
        komunitas: json['komunitas'] != null
            ? Comunity.fromJson(json['komunitas'])
            : null,
        jenjang:
            json['jenjang'] != null ? Jenjang.fromJson(json['jenjang']) : null,
        jabatan:
            json['jabatan'] != null ? Jabatan.fromJson(json['jabatan']) : null,
      );

  Map<String, dynamic> toJson() => {
        'resource_id': resourceId,
        'resource_uuid': resourceUuid,
        'role_id': roleId,
        'username': username,
        'email': email,
        'full_name': fullName,
        'place_of_birth': placeOfBirth,
        'date_of_birth': dateOfBirth,
        'telepon': telepon,
        'image_foto': imageFoto,
        'status': status,
        'komunitas_id': komunitasId,
        'total_login': totalLogin,
        'jenjang_id': jenjangId,
        'jabatan_id': jabatanId,
        'area_province_id': areaProvinceId,
        'area_regencies_id': areaRegenciesId,
        'area_subdistrict_id': areaSubdistrictId,
        'area_village_id': areaVillageId,
        'status_perkawinan': statusPerkawinan,
        'pendidikan': pendidikan,
        'pekerjaan': pekerjaan,
        'jumlah_tanggungan': jumlahTanggungan,
        'foto_selfy': fotoSelfy,
        'foto_ktp': fotoKtp,
        'created_by': createdBy,
        'created_date': createdDate,
        'modified_by': modifiedBy,
        'modified_date': modifiedDate,
        'jabatan_level': jabatanLevel?.code,
        'role': role?.toJson(),
        'province': province?.toJson(),
        'regency': regency?.toJson(),
        'subdistrict': subdistrict?.toJson(),
        'village': village?.toJson(),
        'komunitas': komunitas?.toJson(),
        'jenjang': jenjang?.toJson(),
        'jabatan': jabatan?.toJson(),
      };
}
