enum JabatanLevel {
  admin('admin_kota'),
  ketua('ketua'),
  unknown('public');

  final String code;
  const JabatanLevel(this.code);

  factory JabatanLevel.fromCode(String? type) {
    if (type == null) return JabatanLevel.unknown;

    final normalized = type.trim().toLowerCase();
    return JabatanLevel.values.firstWhere(
      (e) => e.code == normalized,
      orElse: () => JabatanLevel.unknown,
    );
  }
}
