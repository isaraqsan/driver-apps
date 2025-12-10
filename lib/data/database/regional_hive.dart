import 'package:gibas/core/app/constant/alpha_hive.dart';
import 'package:gibas/domain/base/model_api.dart';
import 'package:hive/hive.dart';

part 'regional_hive.g.dart';

@HiveType(typeId: AlphaHive.regionalCode)
class RegionalHive extends HiveObject implements ModelApi {
  
  @HiveField(0)
  int? regionalId;

  @HiveField(1)
  String? siteId;

  @HiveField(2)
  String? namaRegional;

  @HiveField(3)
  String? status;

  @HiveField(4)
  String? branchId;

  @HiveField(5)
  String? companyId;

  @HiveField(6)
  String? headOfficeId;

  @HiveField(7)
  String? createdBy;

  @HiveField(8)
  String? createdDate;

  @HiveField(9)
  String? modifiedBy;

  @HiveField(10)
  String? modifiedDate;

  RegionalHive({
    this.regionalId,
    this.siteId,
    this.namaRegional,
    this.status,
    this.branchId,
    this.companyId,
    this.headOfficeId,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
  });

  @override
  String toString() {
    return '''RegionalHive{
      regionalId: $regionalId, 
      siteId: $siteId, 
      namaRegional: $namaRegional, 
      status: $status, 
      branchId: $branchId, 
      companyId: $companyId, 
      headOfficeId: $headOfficeId, 
      createdBy: $createdBy, 
      createdDate: $createdDate, 
      modifiedBy: $modifiedBy, 
      modifiedDate: $modifiedDate
    }''';
  }

  RegionalHive.fromJson(Map<String, dynamic> json) {
    regionalId = json['regional_id'];
    siteId = json['site_id'];
    namaRegional = json['nama_regional'];
    status = json['status'];
    branchId = json['branch_id'];
    companyId = json['company_id'];
    headOfficeId = json['head_office_id'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    modifiedBy = json['modified_by'];
    modifiedDate = json['modified_date'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['regional_id'] = regionalId;
    data['site_id'] = siteId;
    data['nama_regional'] = namaRegional;
    data['status'] = status;
    data['branch_id'] = branchId;
    data['company_id'] = companyId;
    data['head_office_id'] = headOfficeId;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['modified_by'] = modifiedBy;
    data['modified_date'] = modifiedDate;
    return data;
  }
}
