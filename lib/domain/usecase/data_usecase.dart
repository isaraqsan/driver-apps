import 'package:gibas/core/app/app_config.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/constant.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:gibas/core/service/env_service.dart';

class DataUsecase {
  static String dateNow() {
    return DateFormat('yyyy-MM-dd', AppConfig.dateLocale).format(DateTime.now());
  }

  static String dateTimeNow() => DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  static String dateWithName(String? value) {
    if (value == null) {
      return '-';
    }
    return DateFormat.yMMMMEEEEd(AppConfig.dateLocale).format(DateTime.parse(value));
  }

  static String dateTimeWithName(String? value) {
    String? data = value;
    if (value == null) {
      return '-';
    }
    if (value.contains('+07:00') || value.contains('+08:00') || value.contains('+09:00')) {
      data = value.replaceAll('+07:00', '').replaceAll('+08:00', '').replaceAll('+09:00', '');
    }
    return DateFormat('y MMMM EEEE d HH:mm', AppConfig.dateLocale).format(DateTime.parse(data!));
  }

  static String dateTimeWithNameNoTime(String? value) {
    String? data = value;
    if (value == null) {
      return '-';
    }
    if (value.contains('+07:00') || value.contains('+08:00') || value.contains('+09:00')) {
      data = value.replaceAll('+07:00', '').replaceAll('+08:00', '').replaceAll('+09:00', '');
    }
    return DateFormat.yMMMMEEEEd(AppConfig.dateLocale).format(DateTime.parse(data!));
  }

  static String dateDDMMYY(String? value) {
    return DateFormat.yMd(AppConfig.dateLocale).format(DateTime.parse(value ?? DateTime.now().toString()));
  }

  static String? dateHm(String? value) {
    String? data = value;
    if (value == null) {
      return '--:--';
    }
    if (value.contains('+07:00')) {
      data = value.replaceAll('+07:00', '').replaceAll('+08:00', '').replaceAll('+09:00', '');
    }
    return DateFormat('HH:mm', AppConfig.dateLocale).format(DateTime.parse(data!));
  }

  static String dateYYMMDD(String? value) {
    return DateFormat('yyyy-MM-dd', AppConfig.dateLocale).format(DateTime.parse(value ?? DateTime.now().toString()));
  }

  static String dateMMYY(String? value) {
    return DateFormat.yMMMM(AppConfig.dateLocale).format(DateTime.parse(value ?? DateTime.now().toString()));
  }

  static String dateMonthName(String? value) {
    return DateFormat.MMMM(AppConfig.dateLocale).format(DateTime.parse(value ?? DateTime.now().toString()));
  }

  static String dateMMMd(String? value) {
    return DateFormat.MMMd(AppConfig.dateLocale).format(DateTime.parse(value ?? DateTime.now().toString()));
  }

  static String dateTimeTransaction() => DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

  static String removeTimeZoneTime(String? value) {
    if (value == null) {
      return '-';
    }
    return value.split('(').first;
  }

  static String dateOnlyHourMinuteISO(String? value) {
    if (value == null) {
      return '-';
    }
    final String finalDate = value.replaceAll('T', ' ').replaceAll('+07:00', '').replaceAll('+08:00', '').replaceAll('+09:00', '');
    final formatedDate = DateFormat.Hm(AppConfig.dateLocale).format(DateTime.parse(finalDate));
    return formatedDate;
  }

  static String dateTimeWithNameISO(String? value) {
    if (value == null) {
      return '-';
    }
    final String finalDate = value.replaceAll('T', ' ').replaceAll('+07:00', '').replaceAll('+08:00', '').replaceAll('+09:00', '');
    final formatedDate = DateFormat.yMMMMEEEEd(AppConfig.dateLocale).add_Hm().format(DateTime.parse(finalDate));
    return formatedDate;
  }

  static String time(String? value) {
    if (value == null) {
      return '-';
    }
    return DateFormat('HH:mm').format(DateTime.parse(value));
  }

  static Color statusColor(String? value) {
    switch (value) {
      case Constant.statusDraft:
        return ColorPalette.blueLight;
      case Constant.statusPending:
      case Constant.statusOnProcess:
      case Constant.statusSubmited:
        return ColorPalette.orange;
      case Constant.statusApproved:
      case Constant.statusDone:
        return ColorPalette.primary;
      case Constant.statusReject:
        return ColorPalette.red;
      default:
        return ColorPalette.grey;
    }
  }

  static bool statusCanApprove(String? value) {
    switch (value?.toLowerCase()) {
      case Constant.statusPending:
      case Constant.statusDraft:
      case Constant.statusOnProcess:
        return true;
      default:
        return false;
    }
  }

  static bool statusIsApprove(String? value) {
    switch (value?.toLowerCase()) {
      case Constant.statusApproved:
      case Constant.statusApprove:
        return true;
      default:
        return false;
    }
  }

  static bool statusIsRejected(String? value) {
    switch (value?.toLowerCase()) {
      case Constant.statusReject:
        return true;
      default:
        return false;
    }
  }

  static String timeZoneNow() {
    final DateTime dateTime = DateTime.now();
    return '${dateTime.timeZoneName} - ${dateTime.timeZoneOffset}';
  }

  static String timeWithouTimeZone(String? value) {
    return value?.split(' ').first ?? '';
  }

  static int countDifferentTime(String? startTime, String? endTime) {
    if (startTime == null || endTime == null) {
      return 0;
    }
    final DateTime start = DateFormat('HH:mm').parse(startTime.split(' ').first);
    final DateTime end = DateFormat('HH:mm').parse(endTime.split(' ').first);
    return end.difference(start).inHours;
  }

  static String formatDateTimeZoneOffestManual(String value) {
    if (value.contains('T')) {
      final String datalast = value.split('T').last.split('+').first;
      return datalast;
    } else {
      return '-';
    }
  }

  static String formatHMDateTimeManual(String? value) {
    if (value == null) {
      return '--:--';
    }
    if (value.contains('T')) {
      return value.split('T').last.split('+').first.replaceRange(5, null, '');
    } else {
      return '-';
    }
  }

  static String timeParseFromat(String? value) {
    if (value == null) {
      return '--:--';
    }
    return value.replaceRange(5, null, '');
  }

  static String countDiffTimeHourOvertime(String? startTime, String? endTime) {
    if (startTime == null || endTime == null) {
      return '-';
    }
    final DateTime start = DateFormat('HH:mm').parse(startTime);
    final DateTime end = DateFormat('HH:mm').parse(endTime);
    final int difference = end.difference(start).inHours;
    if (difference > 0) {
      return '$difference Jam';
    } else {
      final DateTime now = DateTime.now();
      final DateTime tempDatetimeEnd = now.copyWith(hour: end.hour, minute: end.minute);
      final DateTime midnight = DateTime(tempDatetimeEnd.year, tempDatetimeEnd.month, tempDatetimeEnd.day);
      final Duration differenceEnd = tempDatetimeEnd.difference(midnight);
      final int totalMinutesEndSinceMidnight = differenceEnd.inMinutes;

      final DateTime tempDatetimeStart = now.copyWith(hour: start.hour, minute: start.minute);
      final DateTime midnightStart = DateTime(tempDatetimeStart.year, tempDatetimeStart.month, tempDatetimeStart.day + 1);
      final Duration differenceStart = midnightStart.difference(tempDatetimeStart);
      final int totalMinutesStartSinceMidnight = differenceStart.inMinutes;

      final Duration total = Duration(minutes: totalMinutesStartSinceMidnight + totalMinutesEndSinceMidnight);
      return '${total.inHours} Jam';
    }
  }

  static String countDiffTimeHour(String? startTime, String? endTime) {
    if (startTime == null || endTime == null) {
      return '-';
    }
    final String finalDateStart = startTime.replaceAll('T', ' ').replaceAll('+07:00', '').replaceAll('+08:00', '').replaceAll('+09:00', '');
    final String finalDateEnd = endTime.replaceAll('T', ' ').replaceAll('+07:00', '').replaceAll('+08:00', '').replaceAll('+09:00', '');
    final DateTime start = DateFormat('yyyy-MM-DD hh:mm:ss').parse(finalDateStart);
    final DateTime end = DateFormat('yyyy-MM-DD hh:mm:ss').parse(finalDateEnd);
    final int difference = end.difference(start).inSeconds;
    return formatSecondsToHHMMSS(difference);
  }

  static String formatSecondsToHHMMSS(int seconds) {
    final int hours = seconds ~/ 3600;
    final int minutes = (seconds % 3600) ~/ 60;

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    return '${twoDigits(hours)}:${twoDigits(minutes)}';
  }

  static int parseToInt(dynamic value) {
    if (value == null) return 0;
    final cleaned = _clearCurrency(value);
    return int.tryParse(cleaned) ?? 0;
  }

  static double parseToDouble(dynamic value) {
    if (value == null) return 0;
    final cleaned = _clearCurrency(value);
    return double.tryParse(cleaned) ?? 0;
  }

  static String _clearCurrency(dynamic value) {
    final str = value.toString().trim();

    final isRupiahFormat = str.contains('IDR') || str.contains('Rp');

    return str.replaceAll('IDR', '').replaceAll('Rp', '').replaceAll('%', '').replaceAll(',', '').replaceAll(isRupiahFormat ? '.' : '', '').replaceAll(' ', '');
  }

  static String currecyFormatter(dynamic value) {
    final double price = double.tryParse(value.toString()) ?? 0;
    final idr = NumberFormat.currency(locale: 'id_ID', decimalDigits: 0, symbol: 'IDR');
    return idr.format(price);
  }

  static String? urlImage(String? value) {
    if ((value?.contains(AppConfig.http) ?? false) || (value?.contains(AppConfig.https) ?? false)) {
      return value;
    }
    if (value == null || value.isEmpty) {
      return null;
    }
    return '${EnvService().baseURL()}uploads/$value';
  }
}
