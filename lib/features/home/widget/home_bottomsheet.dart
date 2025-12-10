import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/domain/usecase/textfield_validator.dart';
import 'package:gibas/shared/component/buttons.dart';
import 'package:gibas/shared/typography/_input_field.dart';
import 'package:gibas/shared/typography/_text_component.dart';
import 'package:gibas/shared/utils/bottomsheet_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBottomsheet {
  static Future<String?> addProgram() async {
    final TextEditingController code = TextEditingController();
    return await BottomsheetHelper.regular(
      title: '',
      isScrollControlled: true,
      content: Padding(
        padding: Dimens.marginContentHorizontal20.copyWith(bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Dimens.marginVerticalLarge(),
            TextComponent.textTitle(
              'Program Baru',
              bold: true,
              textAlign: TextAlign.center,
            ),
            Dimens.marginVerticalLarge(),
            TextComponent.textBody(
              'Masukan code program baru, jika belum memiliki code program silahkan hubungi admin untuk mendapatkan code program',
              textAlign: TextAlign.center,
            ),
            Dimens.marginVerticalLarge(),
            InputField(
              hint: 'Masukan Code Program',
              controller: code,
              validator: TextFieldValidator.regular,
              inputFormatters: TextFieldValidator.inputFormatterRegular(),
            ),
            Dimens.marginVerticalLarge(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Buttons.outlineButton(
                    title: 'Batal',
                    onPressed: () => Get.back(result: false),
                    fitWidth: true,
                  ),
                ),
                Dimens.marginHorizontalMedium(),
                Expanded(
                  child: Buttons.primaryButton(
                    title: 'Konfirmasi',
                    onPressed: () => Get.back(result: code.text),
                    fitWidth: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
