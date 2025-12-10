import 'package:flutter/services.dart';

class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;
    
    // Hanya biarkan angka
    final String cleanText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanText.isEmpty) return TextEditingValue.empty;
    
    // Format ke mata uang
    final numValue = int.parse(cleanText);
    final formattedText = _formatCurrency(numValue);
    
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  String _formatCurrency(int value) => 'IDR${value.toString().replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
}