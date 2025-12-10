import 'package:gibas/core/app/constant/alpha_hive.dart';
import 'package:gibas/data/database/regional_hive.dart';
import 'package:gibas/domain/base/hive_repository.dart';

class RegionalRepository extends HiveRepository<RegionalHive> {
  RegionalRepository() : super(AlphaHive.regional);
}
