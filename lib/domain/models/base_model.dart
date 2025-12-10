class BaseModel {
  dynamic id;
  dynamic name;

  BaseModel({this.id, this.name});

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BaseModel && runtimeType == other.runtimeType && id == other.id;
}
