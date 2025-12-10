import 'package:gibas/core/app/constant/env.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvService {
  bool isProduction = dotenv.get(Env.isProduction.value) == 'true';
  bool debug = dotenv.get(Env.debug.value) == 'true';
  String baseUrlProduction = dotenv.get(Env.baseUrlProduction.value);
  String baseUrlStagging = dotenv.get(Env.baseUrlStagging.value);
  String baseEndpoint = dotenv.get(Env.baseEndpoint.value);
  String sentry = dotenv.get(Env.sentry.value);
  String onesignalAppId = dotenv.get(Env.onesignalAppId.value);

  String baseURL() {
    if (isProduction) {
      return baseUrlProduction;
    } else {
      return baseUrlStagging;
    }
  }

  /// Gabung base URL + endpoint + path
  String fullUrl(String path) {
    final base = baseURL();
    final endpoint = baseEndpoint;
    String url = '$base$endpoint$path';
    // pastikan tidak ada double slash
    url = url.replaceAll(RegExp(r'(?<!:)//'), '/');
    return url;
  }
}
