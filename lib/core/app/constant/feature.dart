enum Feature {
  crc('crc'),
  description('description'),
  detailing('detailing'),
  listing('listing'),
  productSample('product_sample'),
  promotion('promotion'),
  order('order'),
  sos('sos'),
  stockAkhir('stock_akhir'),
  stockAwal('stock_awal'),
  stockOpname('stock_opname'),
  visibility('visibility');

  final String value;

  const Feature(this.value);

  static Feature? fromString(String? value) {
    if (value == null) {
      return null;
    }
    return Feature.values.firstWhere((e) => e.value == value);
  }
}
