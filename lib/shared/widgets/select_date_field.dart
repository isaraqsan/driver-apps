import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gibas/domain/usecase/data_usecase.dart';
import 'package:gibas/domain/usecase/textfield_validator.dart';
import 'package:gibas/shared/typography/_input_field.dart';

class SelectDateField extends StatefulWidget {
  String? label;
  String? hint;
  String? value;
  Function(String value) onChanged;
  bool isRequired;

  SelectDateField({
    super.key,
    this.label,
    this.hint = 'Pilih Tanggal',
    required this.onChanged,
    this.value,
    this.isRequired = false,
  });

  @override
  State<SelectDateField> createState() => _SelectDateFieldState();
}

class _SelectDateFieldState extends State<SelectDateField> {
  final date = TextEditingController();

  @override
  void initState() {
    super.initState();
    date.text = widget.value ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      readOnly: true,
      controller: date,
      label: widget.label,
      hint: widget.hint,
      isRequired: widget.isRequired,
      prefixIcon: CupertinoIcons.calendar,
      suffixIcon: CupertinoIcons.chevron_down_circle_fill,
      validator: widget.isRequired ? TextFieldValidator.regular : null,
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.tryParse(date.text),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) {
          date.text = DataUsecase.dateYYMMDD(pickedDate.toString());
          widget.onChanged(date.text);
        }
      },
    );
  }
}
