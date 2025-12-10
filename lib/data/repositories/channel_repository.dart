import 'package:gibas/core/app/constant/alpha_hive.dart';
import 'package:gibas/data/database/channel_hive.dart';
import 'package:gibas/domain/base/hive_repository.dart';

class ChannelRepository extends HiveRepository<ChannelHive> {
  ChannelRepository() : super(AlphaHive.channel);
}