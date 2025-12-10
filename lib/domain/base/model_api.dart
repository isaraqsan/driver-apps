abstract class ModelApi {
  static T fromJson<T extends ModelApi>(Map<String, dynamic> json) {
    throw UnimplementedError('fromJson must be implemented in the concrete class');
  }

  Map<String, dynamic> toJson();
}
