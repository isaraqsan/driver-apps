import 'package:gibas/core/app/constant/alpha_hive.dart';
import 'package:gibas/domain/base/model_api.dart';
import 'package:hive/hive.dart';

part 'sub_area_hive.g.dart';

@HiveType(typeId: AlphaHive.subAreaCode)
class SubAreaHive extends HiveObject implements ModelApi {
  
  @HiveField(0)
  int? subAreaId;

  @HiveField(1)
  int? areaId;

  @HiveField(2)
  int? regionalId;

  @HiveField(3)
  String? siteId;

  @HiveField(4)
  String? branchId;

  @HiveField(5)
  String? companyId;

  @HiveField(6)
  String? headOfficeId;

  @HiveField(7)
  String? namaArea;

  @HiveField(8)
  String? keterangan;

  @HiveField(9)
  String? status;

  @HiveField(10)
  String? createdBy;

  @HiveField(11)
  String? createdDate;

  @HiveField(12)
  String? modifiedBy;

  @HiveField(13)
  String? modifiedDate;

  SubAreaHive({
    this.subAreaId,
    this.areaId,
    this.regionalId,
    this.siteId,
    this.branchId,
    this.companyId,
    this.headOfficeId,
    this.namaArea,
    this.keterangan,
    this.status,
    this.createdBy,
    this.createdDate,
    this.modifiedBy,
    this.modifiedDate,
  });

  @override
  String toString() {
    return '''SubAreaHive{
      subAreaId: $subAreaId, 
      areaId: $areaId, 
      regionalId: $regionalId, 
      siteId: $siteId, 
      branchId: $branchId, 
      companyId: $companyId, 
      headOfficeId: $headOfficeId, 
      namaArea: $namaArea, 
      keterangan: $keterangan, 
      status: $status, 
      createdBy: $createdBy, 
      createdDate: $createdDate, 
      modifiedBy: $modifiedBy, 
      modifiedDate: $modifiedDate
    }''';
  }

  SubAreaHive.fromJson(Map<String, dynamic> json) {
    subAreaId = json['sub_area_id'];
    areaId = json['area_id'];
    regionalId = json['regional_id'];
    siteId = json['site_id'];
    branchId = json['branch_id'];
    companyId = json['company_id'];
    headOfficeId = json['head_office_id'];
    namaArea = json['nama_area'];
    keterangan = json['keterangan'];
    status = json['status'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    modifiedBy = json['modified_by'];
    modifiedDate = json['modified_date'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_area_id'] = subAreaId;
    data['area_id'] = areaId;
    data['regional_id'] = regionalId;
    data['site_id'] = siteId;
    data['branch_id'] = branchId;
    data['company_id'] = companyId;
    data['head_office_id'] = headOfficeId;
    data['nama_area'] = namaArea;
    data['keterangan'] = keterangan;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['created_date'] = createdDate;
    data['modified_by'] = modifiedBy;
    data['modified_date'] = modifiedDate;
    return data;
  }
}
