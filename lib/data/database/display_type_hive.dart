import 'package:gibas/core/app/constant/alpha_hive.dart';
import 'package:gibas/domain/base/model_api.dart';
import 'package:hive/hive.dart';

part 'display_type_hive.g.dart';

@HiveType(typeId: AlphaHive.displayTypeCode)
class DisplayTypeHive extends HiveObject implements ModelApi {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  DisplayTypeHive({this.id, this.name});

  @override
  String toString() {
    return '''DisplayType{
      id: $id, 
      name: $name
    }''';
  }

  DisplayTypeHive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['display_type'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['display_type'] = name;
    return data;
  }
}
