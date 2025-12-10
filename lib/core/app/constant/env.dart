enum Env {
  debug('DEBUG'),
  isProduction('IS_PRODUCTION'),
  baseUrlProduction('BASE_URL_PRODUCTION'),
  baseUrlStagging('BASE_URL_STAGGING'),
  baseUrlCms('BASE_URL_CMS'),
  baseUrlLocal('BASE_URL_LOCAL'),
  baseEndpoint('BASE_ENDPOINT'),
  onesignalAppId('ONESIGNAL_APP_ID'),
  sentry('SENTRY');

  final String value;

  const Env(this.value);
}
