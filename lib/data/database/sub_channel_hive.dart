import 'package:gibas/core/app/constant/alpha_hive.dart';
import 'package:gibas/domain/base/hive_repository.dart';
import 'package:gibas/domain/base/model_api.dart';

part 'sub_channel_hive.g.dart';

@HiveType(typeId: AlphaHive.subChannelCode)
class SubChannelHive extends HiveObject implements ModelApi {

  @HiveField(0)
  int? id;

  @HiveField(1)
  String? subChannel;

  SubChannelHive({this.id, this.subChannel});

  @override
  String toString() {
    return '''SubChannelHive{
      id: $id, 
      subChannel: $subChannel
    }''';
  }

  SubChannelHive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subChannel = json['sub_channel'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sub_channel'] = subChannel;
    return data;
  }

}