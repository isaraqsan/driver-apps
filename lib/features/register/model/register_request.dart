import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

class RegisterRequest {
  static String _fileNameFromFullName(
      String fullName, String suffix, String ext) {
    final cleanName =
        fullName.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_');
    return '${cleanName}_$suffix.$ext';
  }

  String fullName;
  String dateOfBirth;
  String placeOfBirth;
  String email;
  String telepon;
  String password;
  String confirmPassword;
  String jenjangId;
  String? province;
  String? regency;
  String? district;
  String? village;
  IdLabel? komunitas;

  /// Field tambahan
  List<int>? temaId; // ex: [6,7]
  String? statusPerkawinan;
  String? pendidikan;
  String? pekerjaan;
  String? jumlahTanggungan;
  String? agama;
  String? alamat;
  String? noRegistrasi;

  /// File upload
  File? fotoSelfy;
  File? fotoKtp;
  File? imageFoto;

  RegisterRequest(
      {required this.fullName,
      required this.dateOfBirth,
      required this.placeOfBirth,
      required this.email,
      required this.telepon,
      required this.password,
      required this.confirmPassword,
      required this.jenjangId,
      this.province,
      this.regency,
      this.district,
      this.village,
      this.komunitas,
      this.temaId,
      this.statusPerkawinan,
      this.pendidikan,
      this.pekerjaan,
      this.jumlahTanggungan,
      this.fotoSelfy,
      this.fotoKtp,
      this.imageFoto,
      this.agama,
      this.alamat,
      this.noRegistrasi});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
        jenjangId: json['jenjang_id'] ?? 0,
        fullName: json['full_name'] ?? '',
        dateOfBirth: json['date_of_birth'] ?? '',
        placeOfBirth: json['place_of_birth'] ?? '',
        email: json['email'] ?? '',
        telepon: json['telepon'] ?? '',
        password: json['password'] ?? '',
        confirmPassword: json['confirm_password'] ?? '',
        province: json['area_province_id'] ?? '',
        regency: json['area_regencies_id'] ?? '',
        district: json['area_subdistrict_id'] ?? '',
        village: json['area_village_id'] ?? '',
        komunitas: json['komunitas_id'] != null
            ? IdLabel.fromJson(json['komunitas_id'])
            : null,
        temaId:
            json['tema_id'] != null ? List<int>.from(json['tema_id']) : null,
        statusPerkawinan: json['status_perkawinan'],
        pendidikan: json['pendidikan'],
        pekerjaan: json['pekerjaan'],
        jumlahTanggungan: json['jumlah_tanggungan'],
        agama: json['agama'],
        alamat: json['alamat'],
        noRegistrasi: json['nomor_registrasi']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'full_name': fullName,
      'date_of_birth': dateOfBirth,
      'place_of_birth': placeOfBirth,
      'email': email,
      'jenjang_id': jenjangId,
      'telepon': telepon,
      'password': password,
      'confirm_password': confirmPassword,
      'area_province_id': province,
      'area_regencies_id': regency,
      'area_subdistrict_id': district,
      'area_village_id': village,
      'agama': agama,
      'alamat': alamat,
      'nomor_registrasi': noRegistrasi
    };

    if (komunitas != null) data['komunitas_id'] = komunitas!.toJson();
    if (temaId != null) data['tema_id'] = temaId;
    if (statusPerkawinan != null) data['status_perkawinan'] = statusPerkawinan;
    if (pendidikan != null) data['pendidikan'] = pendidikan;
    if (pekerjaan != null) data['pekerjaan'] = pekerjaan;
    if (jumlahTanggungan != null) data['jumlah_tanggungan'] = jumlahTanggungan;

    return data;
  }

  /// Convert ke Map untuk FormData (support file & multipart)
  Future<Map<String, dynamic>> toMultipartMap() async {
    final Map<String, dynamic> map = {
      'full_name': fullName,
      'date_of_birth': dateOfBirth,
      'place_of_birth': placeOfBirth,
      'email': email,
      'telepon': telepon,
      'password': password,
      'confirm_password': confirmPassword,
      'jenjang_id': jenjangId,
      'area_province_id': province,
      'area_regencies_id': regency,
      'area_subdistrict_id': district,
      'area_village_id': village,
      'agama': agama,
      'alamat': alamat,
      'nomor_registrasi': noRegistrasi,
      if (komunitas != null) 'komunitas_id': komunitas!.value,
      if (temaId != null) 'tema_id': jsonEncode(temaId), // "[6,7]"
      if (statusPerkawinan != null) 'status_perkawinan': statusPerkawinan,
      if (pendidikan != null) 'pendidikan': pendidikan,
      if (pekerjaan != null) 'pekerjaan': pekerjaan,
      'jumlah_tanggungan': int.tryParse(jumlahTanggungan ?? '') ?? 0,

      if (fotoSelfy != null)
        'foto_selfy': await MultipartFile.fromFile(
          fotoSelfy!.path,
          filename: _fileNameFromFullName(
              fullName, 'selfie', fotoSelfy!.path.split('.').last),
        ),
      if (fotoKtp != null)
        'foto_ktp': await MultipartFile.fromFile(
          fotoKtp!.path,
          filename: _fileNameFromFullName(
              fullName, 'ktp', fotoKtp!.path.split('.').last),
        ),
      if (imageFoto != null)
        'image_foto': await MultipartFile.fromFile(
          imageFoto!.path,
          filename: _fileNameFromFullName(
              fullName, 'profile', imageFoto!.path.split('.').last),
        ),
    };

    // Debug print biar bisa cek hasil final sebelum dikirim
    print("🚀 RegisterRequest Multipart Payload:");
    map.forEach((k, v) {
      print("  $k: ${v is MultipartFile ? '📎 FILE(${v.filename})' : v}");
    });

    return map;
  }
}

class IdLabel {
  int value;
  String label;

  IdLabel({required this.value, required this.label});

  factory IdLabel.fromJson(Map<String, dynamic> json) {
    return IdLabel(
      value: json['value'] ?? 0,
      label: json['label'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'value': value, 'label': label};
  }
}
