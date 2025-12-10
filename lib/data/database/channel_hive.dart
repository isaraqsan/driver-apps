import 'package:gibas/core/app/constant/alpha_hive.dart';
import 'package:gibas/domain/base/model_api.dart';
import 'package:hive/hive.dart';

part 'channel_hive.g.dart';

@HiveType(typeId: AlphaHive.channelCode)
class ChannelHive extends HiveObject implements ModelApi {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? channel;

  ChannelHive({this.id, this.channel});

  @override
  String toString() {
    return '''ChannelHive{
      id: $id, 
      channel: $channel
    }''';
  }

  ChannelHive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channel = json['channel'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['channel'] = channel;
    return data;
  }
}
