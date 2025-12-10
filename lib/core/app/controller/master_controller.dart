import 'package:gibas/data/database/brand_hive.dart';
import 'package:gibas/data/database/channel_hive.dart';
import 'package:gibas/data/database/display_type_hive.dart';
import 'package:gibas/data/database/regional_hive.dart';
import 'package:gibas/data/database/sub_area_hive.dart';
import 'package:gibas/data/database/sub_channel_hive.dart';
import 'package:get/get.dart';

class MasterController extends GetxController {
  static MasterController get instance => Get.find();

  final List<DisplayTypeHive> displayTypeList = [];
  final List<BrandHive> brandList = [];
  final List<RegionalHive> regionalList = [];
  final List<SubAreaHive> subAreaList = [];
  final List<ChannelHive> channelList = [];
  final List<SubChannelHive> subChannelList = [];

  

}
