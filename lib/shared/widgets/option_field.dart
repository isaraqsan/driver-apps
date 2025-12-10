import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, GetNavigation;
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/domain/models/base_model.dart';
import 'package:gibas/domain/usecase/textfield_validator.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/_input_field.dart';
import 'package:gibas/shared/typography/typography_component.dart';
import 'package:gibas/shared/utils/bottomsheet_helper.dart';

class OptionField<T extends BaseModel> extends StatefulWidget {
  final T? initialValue;
  final String? label;
  final List<T> options;
  final ValueChanged<T?> onChanged;
  final bool isRequired;

  const OptionField({
    super.key,
    this.initialValue,
    this.label,
    this.isRequired = false,
    required this.options,
    required this.onChanged,
  });

  @override
  State<OptionField<T>> createState() => _OptionFieldState<T>();
}

class _OptionFieldState<T extends BaseModel> extends State<OptionField<T>> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialValue?.name ?? '';
  }

  void showOptions() async {
    await BottomsheetHelper.regular(
      title: widget.label ?? 'Pilih',
      content: buildOptions(),
      maxHeight: 0.8,
      isScrollControlled: true,
    ).then((value) {
      if (value != null) {
        controller.text = value.name;
        widget.onChanged.call(value as T); // <-- Safe cast
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      label: widget.label,
      onTap: showOptions,
      isRequired: widget.isRequired,
      validator: widget.isRequired ? TextFieldValidator.regular : null,
      controller: controller,
      readOnly: true,
      hint: 'Pilih ${widget.label ?? ''}',
      suffixIcon: CupertinoIcons.chevron_down_circle_fill,
    );
  }

  Widget buildOptions() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: widget.options.length,
      itemBuilder: (context, index) {
        final item = widget.options[index];
        return ListTile(
          onTap: () => Get.back(result: item),
          title: TextComponent.textTitle(item.name),
          trailing: Icon(
            item.id == widget.initialValue?.id
                ? CupertinoIcons.checkmark_circle_fill
                : null,
            color: ColorPalette.primary,
          ),
        );
      },
      separatorBuilder: (context, index) => Component.divider(),
    );
  }
}
