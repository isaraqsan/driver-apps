import 'package:gibas/core/service/env_service.dart';

class Constant {
  static const poppinsRegular = 'poppins_regular';

  static const String aplicationName = 'DRIVE';
  static const String https = 'https://';
  static const String http = 'http://';
  static const String schemeWss = 'wss';

  static const String iconPath = 'assets/icons/';
  static const String imagePath = 'assets/images/';

  //* ENV
  static const String env = '.env';
  static const String debug = 'DEBUG';
  static const String isProduction = 'IS_PRODUCTION';
  static const String baseUrlProduction = 'BASE_URL_PRODUCTION';
  static const String baseUrlStagging = 'BASE_URL_STAGGING';
  static const String baseUrlLocal = 'BASE_URL_LOCAL';
  static const String baseEndpoint = 'BASE_ENDPOINT';
  static const String pusherAppId = 'PUSHER_APP_ID';
  static const String pusherAppKey = 'PUSHER_APP_KEY';
  static const String pusherAppSecret = 'PUSHER_APP_SECRET';
  static const String pusherHostProduction = 'PUSHER_HOST_PRODUCTION';
  static const String pusherHostStagging = 'PUSHER_HOST_STAGGING';
  static const String pusherHostLocal = 'PUSHER_HOST_LOCAL';
  static const String pusherPort = 'PUSHER_PORT';
  static const String pusherScheme = 'PUSHER_SCHEME';
  static const String sentryDsn = 'SENTRY_DSN';
  static const String pusherChannel = 'PUSHER_CHANNEL';
  static const String isCrypt = 'IS_CRYPT';
  static String get baseApiUrl {
    final env = EnvService();
    return env.baseURL();
  }

  static String get baseUrlImage {
    return '$baseApiUrl';
  }

  //* Status
  static const String statusDraft = 'draft';
  static const String statusPending = 'pending';
  static const String statusOnProcess = 'on-process';
  static const String statusProcess = 'process';
  static const String statusApproved = 'approved';
  static const String statusApprove = 'approve';
  static const String statusReject = 'rejected';
  static const String statusCancel = 'cancel';
  static const String sattusAccepted = 'accepted';
  static const String statusSubmited = 'submited';
  static const String statusSuccess = 'success';
  static const String statusDone = 'done';
  static const String statusPaid = 'paid';
  static const String statusUnPaid = 'unpaid';
  static const String statusActive = 'active';
  static const String statusDeActive = 'deactive';

  //* Reason Type
  static const String statusAll = 'all';
  static const String statusImplemented = 'implemented';
  static const String statusNotImplemented = 'not-implemented';

  //* Role IDs
  static const int roleAdministrator = 1;
  static const int rolePublic = 3;
  static const int roleAdminPusat = 5;
  static const int roleAdminProvinsi = 6;
  static const int roleAdminKecamatan = 7;
  static const int roleAdminKelurahan = 8;
  static const int roleAdminKota = 2;
}
