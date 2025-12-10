import 'package:gibas/core/app/constant/alpha_hive.dart';
import 'package:gibas/data/database/brand_hive.dart';
import 'package:gibas/domain/base/hive_repository.dart';

class BrandRepository extends HiveRepository<BrandHive> {
  BrandRepository() : super(AlphaHive.brand);
}
