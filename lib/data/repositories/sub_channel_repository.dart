import 'package:gibas/core/app/constant/alpha_hive.dart';
import 'package:gibas/data/database/sub_channel_hive.dart';
import 'package:gibas/domain/base/hive_repository.dart';

class SubChannelRepository extends HiveRepository<SubChannelHive> {
  SubChannelRepository() : super(AlphaHive.subChannel);
}
