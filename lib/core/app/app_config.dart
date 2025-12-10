class AppConfig {
  // * Name
  static const String aplicationName = 'DRIVe';

  // * Path
  static const alphaDir = 'apos';
  static const directory = 'id.act.gibas';
  static const directoryCategory = 'category';

  // * Sort By
  static const String sortByAscending = 'asc';
  static const String sortByDescending = 'desc';

  // * Limit Query
  static const int limitQuery = 50;

  // * URL
  static const String http = 'http://';
  static const String https = 'https://';
  static const String directoryUploadDetailig = 'image_detailing';

  //* Config API
  static const String cacheControl = 'no-cache';
  static const String contentTypeJson = 'application/json';
  static const String contentTypeUrlEncoded = 'application/x-www-form-urlencoded';

  //* Map
  static const String tileMap = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';

  //* Config Time
  static const int durationShimmer = 1200;
  static const Duration timeRequestApi = Duration(seconds: 30);
  static const Duration timeRequestFace = Duration(seconds: 60);
  static const Duration durationBounce = Duration(milliseconds: 800);

  //* Config Date Locale
  static const String dateLocale = 'id';
}
