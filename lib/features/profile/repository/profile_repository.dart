import 'dart:io';

import 'package:gibas/domain/base/repository.dart';
import 'package:gibas/features/global/model/resource_response.dart';
import 'package:gibas/features/profile/model/card_response.dart';
import 'package:gibas/features/profile/model/users_request.dart';

class ProfileRepository extends Repository {
  Future<DataResult<Resource>> getProfile(String id) async {
    return await dioService.get(
      url: '${Endpoint.profile}/$id',
      fromJsonT: (data) => Resource.fromJson(data),
    );
  }

  Future<DataResult> delete(String id) async {
    return await dioService.delete(
      url: '${Endpoint.profile}/$id',
      fromJsonT: (data) => DataResult.fromJson(data),
    );
  }

  Future<DataResult<GenerateCardResponse>> getCard(UsersRequest body) async {
    final res = await dioService.post(
      url: Endpoint.memberCard,
      body: body.toJson(),
    );

    if (res.data is Map<String, dynamic>) {
      final dataMap = res.data as Map<String, dynamic>;
      final card = GenerateCardResponse(
        status: dataMap['status'] ?? false,
        message: dataMap['message'] ?? '',
        data: dataMap['data'] ?? '',
      );
      return DataResult.success(dataValue: card);
    } else if (res.data is String) {
      // kalau res.data cuma string path PDF
      final card = GenerateCardResponse(
        status: true,
        message: 'generate card',
        data: res.data,
      );
      return DataResult.success(dataValue: card);
    } else {
      return DataResult.failed(messageValue: 'Unexpected response type');
    }
  }

  Future<DataResult<Resource>> updateProfile(
      {required String uuid,
      required int id,
      required String roleId,
      required String roleLabel,
      required String fullName,
      required String email,
      required String telepon,
      required String password,
      required String jenjangId,
      File? imageFoto,
      File? fotoSelfy,
      File? fotoKtp,
      required String placeOfBirth,
      required String dateOfBirth,
      String? areaRegencyId,
      String? areaProvinceId,
      String? areaSubdistrictId,
      String? areaVillageId,
      String? agama,
      String? alamat,
      String? nomorRegistrasi}) async {
    final formData = {
      'role_id': roleId,
      'full_name': fullName,
      'email': email,
      'telepon': telepon,
      if (agama != null || agama != '') 'agama': agama,
      if (alamat != null || alamat != '') 'alamat': alamat,
      if (nomorRegistrasi != null || nomorRegistrasi != '')
        'nomor_registrasi': nomorRegistrasi,
      if (password.isNotEmpty) 'password': password,
      if (imageFoto != null)
        'image_foto': await dioService.multipartFile(imageFoto),
      if (fotoSelfy != null)
        'foto_selfy': await dioService.multipartFile(fotoSelfy),
      if (fotoKtp != null) 'foto_ktp': await dioService.multipartFile(fotoKtp),
      'place_of_birth': placeOfBirth,
      'date_of_birth': dateOfBirth,
      'jenjang_id': jenjangId,
      if (areaRegencyId != null &&
          areaRegencyId.isNotEmpty &&
          areaRegencyId != '0')
        'area_regencies_id': areaRegencyId,
      if (areaProvinceId != null &&
          areaProvinceId.isNotEmpty &&
          areaProvinceId != '0')
        'area_province_id': areaProvinceId,
      if (areaSubdistrictId != null &&
          areaSubdistrictId.isNotEmpty &&
          areaSubdistrictId != '0')
        'area_subdistrict_id': areaSubdistrictId,
      if (areaVillageId != null &&
          areaVillageId.isNotEmpty &&
          areaVillageId != '0')
        'area_village_id': areaVillageId,
    };

    return await dioService.putMultipart(
      url: '${Endpoint.profile}/$uuid',
      data: formData,
      fromJsonT: (data) => Resource.fromJson(data),
    );
  }
}
