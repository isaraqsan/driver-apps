class Profile {
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
  final int totalLogin;
  final int? areaProvinceId;
  final int? areaRegenciesId;
  final int? areaDistrictsId;
  final int? areaVillageId;
  final String? statusPerkawinan;
  final String? pekerjaan;
  final int? jumlahTanggungan;
  final String? fotoKtp;
  final String? fotoSelfy;
  final int createdBy;
  final String createdDate;
  final int? modifiedBy;
  final String? modifiedDate;
  final String? pendidikan;
  final Role role;
  final Province province;
  final Regency regency;
  final Komunitas komunitas;
  final List<Tema> tema;

  Profile({
    required this.resourceId,
    required this.resourceUuid,
    required this.roleId,
    required this.username,
    required this.email,
    required this.fullName,
    required this.placeOfBirth,
    required this.dateOfBirth,
    required this.telepon,
    this.imageFoto,
    required this.status,
    required this.komunitasId,
    required this.totalLogin,
    required this.areaProvinceId,
    required this.areaRegenciesId,
    required this.createdBy,
    required this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
    required this.role,
    required this.province,
    required this.regency,
    required this.komunitas,
    required this.tema,
    this.areaDistrictsId,
    this.areaVillageId,
    this.statusPerkawinan,
    this.pekerjaan,
    this.jumlahTanggungan,
    this.fotoKtp,
    this.fotoSelfy,
    this.pendidikan,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        resourceId: json['resource_id'] ?? 0,
        resourceUuid: json['resource_uuid'] ?? '',
        roleId: json['role_id'] ?? 0,
        username: json['username'] ?? '',
        email: json['email'] ?? '',
        fullName: json['full_name'] ?? '',
        placeOfBirth: json['place_of_birth'] ?? '',
        dateOfBirth: json['date_of_birth'] ?? '',
        telepon: json['telepon'] ?? '',
        imageFoto: json['image_foto'],
        status: json['status'] ?? '',
        komunitasId: json['komunitas_id'] ?? 0,
        totalLogin: json['total_login'] ?? 0,
        areaProvinceId: json['area_province_id'] ?? 0,
        areaRegenciesId: json['area_regencies_id'] ?? 0,
        areaDistrictsId: json['area_subdistrict_id'],
        areaVillageId: json['area_village_id'],
        statusPerkawinan: json['status_perkawinan'],
        pekerjaan: json['pekerjaan'],
        jumlahTanggungan: json['jumlah_tanggungan'],
        fotoKtp: json['foto_ktp'],
        fotoSelfy: json['foto_selfy'],
        pendidikan: json['pendidikan'],
        createdBy: json['created_by'] ?? 0,
        createdDate: json['created_date'] ?? '',
        modifiedBy: json['modified_by'],
        modifiedDate: json['modified_date'],
        role: Role.fromJson(json['role'] ?? {}),
        province: Province.fromJson(json['province'] ?? {}),
        regency: Regency.fromJson(json['regency'] ?? {}),
        komunitas: Komunitas.fromJson(json['komunitas'] ?? {}),
        tema: (json['tema'] as List<dynamic>? ?? [])
            .map((e) => Tema.fromJson(e))
            .toList(),
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
        'area_province_id': areaProvinceId,
        'area_regencies_id': areaRegenciesId,
        'area_subdistrict_id': areaDistrictsId,
        'area_village_id': areaVillageId,
        'status_perkawinan': statusPerkawinan,
        'pekerjaan': pekerjaan,
        'jumlah_tanggungan': jumlahTanggungan,
        'foto_ktp': fotoKtp,
        'foto_selfy': fotoSelfy,
        'pendidikan': pendidikan,
        'created_by': createdBy,
        'created_date': createdDate,
        'modified_by': modifiedBy,
        'modified_date': modifiedDate,
        'role': role.toJson(),
        'province': province.toJson(),
        'regency': regency.toJson(),
        'komunitas': komunitas.toJson(),
        'tema': tema.map((e) => e.toJson()).toList(),
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

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json['role_id'] ?? 0,
        roleName: json['role_name'] ?? '',
        status: json['status'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'role_id': roleId,
        'role_name': roleName,
        'status': status,
      };
}

class Province {
  final int id;
  final String name;

  Province({required this.id, required this.name});

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
      );

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

  factory Regency.fromJson(Map<String, dynamic> json) => Regency(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        areaProvinceId: json['area_province_id'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "area_province_id": areaProvinceId,
      };
}

class Komunitas {
  final int id;
  final String komunitasName;
  final int type;
  final String? iconImage;

  Komunitas({
    required this.id,
    required this.komunitasName,
    required this.type,
    this.iconImage,
  });

  factory Komunitas.fromJson(Map<String, dynamic> json) => Komunitas(
        id: json['id'] ?? 0,
        komunitasName: json['komunitas_name'] ?? '',
        type: json['type'] ?? 0,
        iconImage: json['icon_image'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "komunitas_name": komunitasName,
        "type": type,
        "icon_image": iconImage,
      };
}

class Tema {
  final int id;
  final String temaName;
  final int type;
  final String? iconImage;

  Tema({
    required this.id,
    required this.temaName,
    required this.type,
    this.iconImage,
  });

  factory Tema.fromJson(Map<String, dynamic> json) => Tema(
        id: json['id'] ?? 0,
        temaName: json['tema_name'] ?? '',
        type: json['type'] ?? 0,
        iconImage: json['icon_image'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'tema_name': temaName,
        'type': type,
        'icon_image': iconImage,
      };
}
