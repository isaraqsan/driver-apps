enum HiveKey {
  token('token'),
  auth('auth'),
  introduce('introduce'),
  locationLastTime('location_last_time'),
  locationLast('location_last');

  final String key;

  const HiveKey(this.key);
}