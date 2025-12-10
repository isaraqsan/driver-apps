enum ResponseStatus {
  // * From Api
  success('true'),
  failed('false'),
  unauthorized('04'),
  internalServerError('500'),
  dataNotFound('404'),
  dataEmpty('202'),
  unknown('99');

  final String code;

  const ResponseStatus(this.code);

  factory ResponseStatus.fromCode(String? code) {
    if (code != null) {
      return ResponseStatus.values.firstWhere(
        (e) => e.code == code,
        orElse: () => ResponseStatus.unknown,
      );
    }
    return ResponseStatus.unknown;
  }
}
