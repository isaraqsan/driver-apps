enum ImageType {
  checkin('IMG_CHECKIN'),
  checkout('checkout'),
  crc('crc'),
  detailing('IMG_DETAILING'),
  newOutlet('NEW_OUTLET'),
  order('order'),
  outlet('OUTLET'),
  product('product'),
  promo('IMG_PROMO'),
  sos('IMG_SOS'),
  po('IMG_PO');

  final String value;

  const ImageType(this.value);

  static ImageType? fromString(String? value) {
    if (value == null) {
      return null;
    }
    return ImageType.values.firstWhere((element) => element.value == value);
  }
}
