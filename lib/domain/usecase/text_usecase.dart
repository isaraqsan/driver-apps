import 'package:gibas/core/app/constant/image_type.dart';

class TextUsecase {
  static String imageTypeName(ImageType? value) {
    return switch (value) {
      ImageType.checkin => 'Check In',
      ImageType.checkout => 'Check Out',
      ImageType.crc => throw UnimplementedError(),
      ImageType.detailing => 'Detailing',
      ImageType.newOutlet => throw UnimplementedError(),
      ImageType.order => 'Order',
      ImageType.outlet => throw UnimplementedError(),
      ImageType.po => 'PO',
      ImageType.product => throw UnimplementedError(),
      ImageType.promo => throw UnimplementedError(),
      ImageType.sos => throw UnimplementedError(),
      _ => 'Image',
    };
  }

  static String cleanString(String input) {
    return input
        .trim() // Hilangkan spasi di awal & akhir
        .replaceAll(RegExp(r'\s+'), ' '); // Ganti banyak spasi jadi satu spasi
  }
}
