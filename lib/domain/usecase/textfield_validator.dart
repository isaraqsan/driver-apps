import 'package:flutter/services.dart';
import 'package:gibas/core/utils/currency_input_format.dart';

class TextFieldValidator {
  static bool isValid(String value) {
    return value.isNotEmpty;
  }

  static String? regular(String? value) {
    if (value == null || value.isEmpty) return 'Tidak boleh kosong';
    return null;
  }

  static String? number(String? value) {
    if (value == null) return 'Tidak boleh kosong';
    if (value.isEmpty) return 'Tidak boleh kosong';
    return null;
  }

  static String? email(String? value) {
    if (value == null) return 'Email tidak boleh kosong';
    if (value.isEmpty) return 'Email tidak boleh kosong';
    if (value.length < 4) {
      return 'Email minimal 4 karakter';
    } else {
      return null;
    }
  }

  static String? password(String? value) {
    if (value == null) return 'Password tidak boleh kosong';
    if (value.isEmpty) return 'Password tidak boleh kosong';
    if (value.length < 6) {
      return 'Password minimal 6 karakter';
    } else {
      return null;
    }
  }

  static String? requiredIfVisible(String? value, bool isVisible) {
    if (!isVisible) return null;
    if (value == null || value.trim().isEmpty) return 'Tidak boleh kosong';
    return null;
  }

  static List<TextInputFormatter> inputFormatterRegular() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s]')),
    ];
  }

  static List<TextInputFormatter> inputFormatterCurrency() {
    return [
      FilteringTextInputFormatter.digitsOnly,
      CurrencyTextInputFormatter(),
    ];
  }
}
