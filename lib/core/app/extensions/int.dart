extension IntExtension on int {
  String toCurrency() => 'Rp ${toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';

  String toStringWithDefault() => toString().isEmpty ? '0' : toString();
}
