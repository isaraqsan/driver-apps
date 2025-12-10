import 'dart:io';

import 'package:gibas/domain/base/repository.dart';
import 'package:gibas/domain/models/base_params.dart';
import 'package:gibas/features/global/model/article.dart';
import 'package:gibas/features/global/model/article_detail.dart';
import 'package:gibas/features/global/model/article_trending.dart';
import 'package:gibas/features/global/model/article_response.dart';
import 'package:gibas/features/global/model/jabatan.dart';
import 'package:gibas/features/global/model/jenjang.dart';
import 'package:gibas/features/global/model/like.dart';
import 'package:gibas/features/global/model/province.dart';
import 'package:gibas/features/global/model/regency.dart';
import 'package:gibas/features/global/model/resource_response.dart';
import 'package:gibas/features/global/model/sub_district_response.dart';
import 'package:gibas/features/global/model/village_response.dart';

class GlobalRepository extends Repository {
  Future<DataResult<Province>> listProvince() async {
    return await dioService.get(
      url: Endpoint.areaProvince,
      fromJsonT: (data) => Province.fromJson(data),
    );
  }

  Future<DataResult<Regency>> listRegency({required int provinceId}) async {
    final url = '${Endpoint.areaRegency}/$provinceId'; // sisipkan ID dinamis
    return await dioService.get(
      url: url,
      fromJsonT: (data) => Regency.fromJson(data),
    );
  }

  Future<DataResult<SubDistrictResponse>> listSubDistrict({
    BaseParams? params,
  }) async {
    final url = Endpoint.areaSubDistrict;

    return await dioService.get(
      url: url,
      param: params?.toJson(),
      fromJsonT: (data) => SubDistrictResponse.fromJson(data),
    );
  }

  Future<DataResult<VillageResponse>> listVillage({
    BaseParams? params,
  }) async {
    final url = Endpoint.areaVillage;

    return await dioService.get(
      url: url,
      param: params?.toJson(),
      fromJsonT: (data) => VillageResponse.fromJson(data),
    );
  }

  Future<DataResult<Jenjang>> listJenjang() async {
    final url = Endpoint.jenjang; // sisipkan ID dinamis
    return await dioService.get(
      url: url,
      fromJsonT: (data) => Jenjang.fromJson(data),
    );
  }

  Future<DataResult<Jabatan>> listJabatan() async {
    final url = Endpoint.jabatan;
    return await dioService.get(
      url: url,
      fromJsonT: (data) => Jabatan.fromJson(data),
    );
  }

  Future<DataResult<Jabatan>> listJabatanByJenjang(String jenjangId) async {
    final url = '${Endpoint.jabatanByJenjang}/$jenjangId';
    return await dioService.get(
      url: url,
      fromJsonT: (data) => Jabatan.fromJson(data),
    );
  }

  Future<DataResult<ArticleTrending>> listArticleTrending() async {
    return await dioService.get(
      url: Endpoint.articlesTrending,
      fromJsonT: (data) => ArticleTrending.fromJson(data),
    );
  }

  Future<DataResult<ArticleDetail>> detailArticle(String title) async {
    return await dioService.get(
      url: '${Endpoint.articles}/$title',
      fromJsonT: (data) => ArticleDetail.fromJson(data),
    );
  }

  Future<DataResult<ArticleResponse>> listArticle({
    required int page,
    required int perPage,
    String? q,
    String? type,
  }) async {
    final url = Endpoint.articles;

    return await dioService.get(
      url: url,
      param: {
        'page': page,
        'perPage': perPage,
        'q': q ?? '',
        'type': type ?? 'fe',
      },
      fromJsonT: (data) => ArticleResponse.fromJson(data),
    );
  }

  Future<DataResult<ResourceResponse>> getMember({
    required int page,
    int perPage = 10,
    String? q,
    String? type,
  }) async {
    final url = Endpoint.updateProfile;

    return await dioService.get(
      url: url,
      param: {
        'page': page,
        'perPage': perPage,
        'q': q ?? '',
      },
      fromJsonT: (data) => ResourceResponse.fromJson(data),
    );
  }

  Future<DataResult<void>> createArticle({
    required String categoryName,
    required String title,
    required String description,
    required File image,
  }) async {
    final formData = {
      'category_name': categoryName,
      'title': title,
      'description': description,
      'image': await dioService.multipartFile(image),
    };

    return await dioService.postMultipart(
      url: Endpoint.articles, // should be 'forum/article'
      data: formData,
    );
  }

  Future<DataResult> like(Like body) async {
    return await dioService.post(
      url: Endpoint.likeArticle,
      body: body.toJson(),
    );
  }
}
