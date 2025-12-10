extension DateTimeExtension on DateTime {
  String toFormattedString() {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/$year';
  }

  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
}
