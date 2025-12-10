import 'package:gibas/core/app/constant/alpha_hive.dart';
import 'package:gibas/data/database/sub_area_hive.dart';
import 'package:gibas/domain/base/hive_repository.dart';

class SubAreaRepository extends HiveRepository<SubAreaHive> {
  SubAreaRepository() : super(AlphaHive.subArea);
}
