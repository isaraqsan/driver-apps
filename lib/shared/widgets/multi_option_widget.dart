import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, GetNavigation;
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/domain/models/base_model.dart';
import 'package:gibas/domain/usecase/textfield_validator.dart';
import 'package:gibas/shared/component/buttons.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/_input_field.dart';
import 'package:gibas/shared/typography/_text_component.dart';
import 'package:gibas/shared/utils/bottomsheet_helper.dart';

class MultiOptionWidget extends StatefulWidget {
  final List<BaseModel>? initialValue;
  String? label;
  final List<BaseModel> options;
  final Function(List<BaseModel> value) onChanged;
  bool isRequired;

  MultiOptionWidget({
    super.key,
    this.initialValue,
    this.label,
    required this.options,
    required this.onChanged,
    this.isRequired = false,
  });

  @override
  State<MultiOptionWidget> createState() => _MultiOptionWidgetState();
}

class _MultiOptionWidgetState extends State<MultiOptionWidget> {
  final controller = TextEditingController();
  final List<BaseModel> selectedOptions = [];

  @override
  void initState() {
    selectedOptions.clear();
    selectedOptions.addAll(widget.initialValue ?? []);
    super.initState();
  }

  void showOptions() async {
    await BottomsheetHelper.regular(
      title: widget.label ?? 'Pilih',
      content: _MultiOptionsList(
        initialValue: widget.initialValue,
        options: widget.options,
      ),
      maxHeight: 0.8,
      isScrollControlled: true,
    ).then((value) {
      if (value != null) {
        value as List<BaseModel>;
        selectedOptions.clear();
        selectedOptions.addAll(value);
        setState(() {});
        widget.onChanged(selectedOptions);
      }
    });
  }

  void onRemoveSelected(dynamic id) {
    setState(() {
      selectedOptions.removeWhere((e) => e.id == id);
    });
    widget.onChanged(selectedOptions);
  }

  String? Function(String?)? checkRequiredValidator() {
    if (widget.isRequired) {
      return selectedOptions.isNotEmpty ? null : TextFieldValidator.regular;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputField(
          label: widget.label,
          onTap: showOptions,
          isRequired: widget.isRequired,
          controller: controller,
          readOnly: true,
          validator: checkRequiredValidator(),
          hint: 'Pilih ${widget.label ?? ''}',
          suffixIcon: CupertinoIcons.chevron_down_circle_fill,
        ),
        buildSelectedOptions(),
      ],
    );
  }

  Widget buildSelectedOptions() {
    if (selectedOptions.isEmpty) {
      return Container();
    } else {
      return Wrap(
        spacing: 8,
        children: List.generate(
          selectedOptions.length,
          (index) {
            return Container(
              margin: EdgeInsets.only(right: 8, top: 4, bottom: index == selectedOptions.length - 1 ? 16 : 0),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorPalette.primary,
                borderRadius: BorderRadius.circular(Dimens.radiusLarge),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: TextComponent.textTitle(selectedOptions[index].name, type: TextTitleType.m3)),
                  Dimens.marginHorizontalSmall(),
                  InkWell(
                    onTap: () => onRemoveSelected(selectedOptions[index].id),
                    child: const Icon(
                      Icons.close,
                      size: Dimens.iconSizeSmall,
                      color: ColorPalette.white,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }
}

class _MultiOptionsList extends StatefulWidget {
  final List<BaseModel> options;
  final List<BaseModel>? initialValue;
  const _MultiOptionsList({
    required this.options,
    required this.initialValue,
  });

  @override
  State<_MultiOptionsList> createState() => __MultiOptionsListState();
}

class __MultiOptionsListState extends State<_MultiOptionsList> {
  final List<BaseModel> filterOptions = [];
  final List<BaseModel> selectedOptions = [];
  final search = TextEditingController();

  @override
  void initState() {
    selectedOptions.clear();
    filterOptions.clear();
    selectedOptions.addAll(widget.initialValue ?? []);
    filterOptions.addAll(widget.options);
    super.initState();
  }

  void onSelectOption(int index) {
    setState(() {
      if (selectedOptions.contains(filterOptions[index])) {
        selectedOptions.remove(filterOptions[index]);
      } else {
        selectedOptions.add(filterOptions[index]);
      }
    });
  }

  void onSearch(String? value) {
    setState(() {
      filterOptions.clear();
      filterOptions.addAll(widget.options.where((e) => e.name.toLowerCase().contains(value!.toLowerCase())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Dimens.marginContentHorizontal,
          child: InputField(
            controller: search,
            onChanged: onSearch,
            prefixIcon: CupertinoIcons.search,
          ),
        ),
        Dimens.marginVerticalSmall(),
        Flexible(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: filterOptions.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => onSelectOption(index),
                title: TextComponent.textTitle(filterOptions[index].name),
                trailing: selectedOptions.contains(filterOptions[index])
                    ? const Icon(
                        Icons.check_circle,
                        color: ColorPalette.primary,
                      )
                    : const Icon(
                        Icons.circle_outlined,
                      ),
              );
            },
            separatorBuilder: (context, index) => Component.divider(),
          ),
        ),
        Padding(
          padding: Dimens.marginContentHorizontal,
          child: Row(
            children: [
              Expanded(
                child: Buttons.outlineButton(
                  title: 'Batal',
                  onPressed: () => Get.back(),
                  fitWidth: true,
                ),
              ),
              Dimens.marginHorizontalMedium(),
              Expanded(
                child: Buttons.primaryButton(
                  title: 'Simpan',
                  onPressed: () {
                    Get.back(result: selectedOptions);
                  },
                  fitWidth: true,
                ),
              ),
            ],
          ),
        ),
        Dimens.marginVerticalMedium(),
      ],
    );
  }
}
