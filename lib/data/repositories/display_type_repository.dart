import 'package:gibas/core/app/constant/alpha_hive.dart';
import 'package:gibas/data/database/display_type_hive.dart';
import 'package:gibas/domain/base/hive_repository.dart';

class DisplayTypeRepository extends HiveRepository<DisplayTypeHive> {
  DisplayTypeRepository() : super(AlphaHive.displayType);
}
