import 'package:get/get.dart' show Get, Inst;

class DependencyUtil {
  static Future<T> safePut<T>(T Function() builder, {bool permanent = false}) async {
    if (!Get.isRegistered<T>()) {
      return Get.put<T>(builder(), permanent: permanent);
    } else {
      return Get.find<T>();
    }
  }

  static Future<T> safePutAsync<T>(Future<T> Function() builder, {bool permanent = false}) async {
    if (!Get.isRegistered<T>()) {
      return await Get.putAsync<T>(builder, permanent: permanent);
    } else {
      return Get.find<T>();
    }
  }

  static Future<bool> safeDelete<T>(Future<T> Function() builder) async {
    if (Get.isRegistered<T>()) {
      return await Get.delete<T>();
    }
    return false;
  }
}
