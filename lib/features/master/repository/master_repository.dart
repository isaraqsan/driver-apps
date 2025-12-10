import 'package:gibas/data/database/brand_hive.dart';
import 'package:gibas/data/database/channel_hive.dart';
import 'package:gibas/data/database/display_type_hive.dart';
import 'package:gibas/data/database/regional_hive.dart';
import 'package:gibas/data/database/sub_area_hive.dart';
import 'package:gibas/data/database/sub_channel_hive.dart';
import 'package:gibas/domain/base/repository.dart';

class MasterRepository extends Repository {
  Future<DataResult<BrandHive>> brand() async {
    return await dioService.post(
      url: Endpoint.globalBrand,
      fromJsonT: (data) => BrandHive.fromJson(data),
    );
  }

  Future<DataResult<DisplayTypeHive>> displayType() async {
    return await dioService.post(
      url: Endpoint.globalDisplayType,
      fromJsonT: (data) => DisplayTypeHive.fromJson(data),
    );
  }

  // Future<DataResult<RegionalHive>> areaRegion() async {
  //   return await dioService.get(
  //     url: Endpoint.areaRegion,
  //     fromJsonT: (data) => RegionalHive.fromJson(data),
  //   );
  // }

  Future<DataResult<SubAreaHive>> areaSubArea() async {
    return await dioService.get(
      url: Endpoint.areaSubArea,
      fromJsonT: (data) => SubAreaHive.fromJson(data),
    );
  }

  Future<DataResult<ChannelHive>> channel() async {
    return await dioService.post(
      url: Endpoint.globalChannel,
      fromJsonT: (data) => ChannelHive.fromJson(data),
    );
  }

  Future<DataResult<SubChannelHive>> subChannel() async {
    return await dioService.post(
      url: Endpoint.globalSubChannel,
      fromJsonT: (data) => SubChannelHive.fromJson(data),
    );
  }
}
