import 'package:gibas/core/app/constant/alpha_hive.dart';
import 'package:gibas/domain/base/model_api.dart';
import 'package:hive/hive.dart';

part 'brand_hive.g.dart';

@HiveType(typeId: AlphaHive.brandCode)
class BrandHive extends HiveObject implements ModelApi {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  BrandHive({this.id, this.name});

  @override
  String toString() {
    return '''BrandHive{
      id: $id, 
      name: $name
    }''';
  }

  BrandHive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['brand'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['brand'] = name;
    return data;
  }
}
