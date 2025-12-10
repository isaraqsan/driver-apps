import 'package:intl/intl.dart' show NumberFormat;

extension StringExtension on String {
  String formatCurrency({String? symbol = 'Rp', bool useSymbol = true}) {
    if (!useSymbol) symbol = '';
    final double price = double.tryParse(this) ?? 0;
    final idr = NumberFormat.currency(locale: 'id_ID', decimalDigits: 0, symbol: symbol);
    return idr.format(price);
  }
}
