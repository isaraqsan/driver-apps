import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/features/register/model/register_request.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/typography_component.dart';

class BottomSheetPicker {
  static Future<IdLabel?> show({
    required BuildContext context,
    required String title,
    required List<IdLabel> items,
    IdLabel? selected,
    double? maxHeight,
  }) async {
    TextEditingController searchController = TextEditingController();
    List<IdLabel> filtered = List.from(items);

    return showModalBottomSheet<IdLabel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: ColorPalette.white,
      shape: Component.bottomsheetShape(),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          void filterItems(String query) {
            setState(() {
              filtered = items
                  .where((e) =>
                      e.label.toLowerCase().contains(query.toLowerCase()))
                  .toList();
            });
          }

          return Container(
            height:
                maxHeight != null ? Get.height * maxHeight : Get.height * 0.95,
            child: SafeArea(
              child: Column(
                children: [
                  Dimens.marginVerticalMedium(),
                  Container(
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: ColorPalette.greyBorder,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Dimens.marginVerticalMedium(),
                  Padding(
                    padding: Dimens.marginContentHorizontal20,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextComponent.textTitle(title, bold: true),
                        ),
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorPalette.white2,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: Dimens.iconSizeSmall,
                              color: ColorPalette.blackText,
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ),
                  Dimens.marginVerticalMedium(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: searchController,
                      onChanged: filterItems,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(CupertinoIcons.search),
                        hintText: 'Cari...',
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final item = filtered[index];
                        final isSelected = selected?.value == item.value;
                        return ListTile(
                          title: Text(item.label),
                          trailing: isSelected
                              ? const Icon(CupertinoIcons.check_mark)
                              : null,
                          onTap: () => Navigator.pop(context, item),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
