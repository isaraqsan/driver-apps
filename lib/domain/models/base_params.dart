import 'package:gibas/core/app/app_config.dart';
import 'package:gibas/domain/base/model_api.dart';

class BaseParams extends ModelApi {
  int page = 1;
  int? limit;
  String? sortBy;
  String? sortDir;
  String? name;
  int? siteId;
  int? userId;
  String? startTime;
  String? endTime;
  String? status;
  int? categoryId;
  int? orderId;
  int? supplierId;
  int? programId;
  dynamic id;
  String? search;
  String? provinceId;
  String? regencyId;
  String? subDistrictId;
  String? perPage;
  String? group;
  String? idExternal;

  BaseParams({
    this.page = 1,
    this.limit = AppConfig.limitQuery,
    this.sortBy,
    this.sortDir,
    this.name,
    this.siteId,
    this.userId,
    this.startTime,
    this.endTime,
    this.status,
    this.categoryId,
    this.orderId,
    this.supplierId,
    this.programId,
    this.id,
    this.search,
    this.provinceId,
    this.regencyId,
    this.subDistrictId,
    this.perPage,
    this.group,
    this.idExternal,
  });

  @override
  BaseParams.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
    limit = json['limit'];
    sortBy = json['sort_by'];
    sortDir = json['sort_dir'];
    name = json['name'];
    siteId = json['site_id'];
    userId = json['user_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    categoryId = json['category_id'];
    orderId = json['order_id'];
    id = json['id'];
    programId = json['program_id'];
    supplierId = json['supplier_id'];
    search = json['q'];
    provinceId = json['province_id'];
    regencyId = json['regency_id'];
    subDistrictId = json['subdistrict_id'];
    group = json['group'];
    idExternal = json['id_external'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['perPage'] = perPage;
    data['sort_by'] = sortBy;
    data['sort_dir'] = sortDir;
    data['name'] = name;
    data['site_id'] = siteId;
    data['user_id'] = userId;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    data['category_id'] = categoryId;
    data['order_id'] = orderId;
    data['id'] = id;
    data['program_id'] = programId;
    data['supplier_id'] = supplierId;
    data['q'] = search;
    data['province_id'] = provinceId;
    data['regency_id'] = regencyId;
    data['subdistrict_id'] = subDistrictId;
    data['group'] = group;
    data['id_external'] = idExternal;
    data.removeWhere((key, value) => value == null);
    return data;
  }

  BaseParams.withDate() {
    // siteId = AuthController.instance.authEntity.user?.siteId;
    // sortDir = AppConfig.sortByDescending;
    // startTime = DataUsecase.dateYYMMDD(DateTime.now().subtract(const Duration(days: 180)).toString());
    // endTime = DataUsecase.dateYYMMDD(DateTime.now().subtract(const Duration(days: -1)).toString());
  }
}
