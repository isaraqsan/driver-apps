
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:gibas/shared/typography/typography_component.dart';

class ComingSoonWidget extends StatelessWidget {
  final String? title;
  final String? description;

  const ComingSoonWidget({
    this.title,
    this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: SizeConfig.blockSizeHorizontal * 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextComponent.textTitle(
              title ?? 'Fitur akan segera tersedia!',
              textAlign: TextAlign.center,
            ),
            Dimens.marginVerticalMedium(),
            TextComponent.textBody(
              description ?? 'Saat ini fitur masih dalam tahap develop, kami akan membuat aplikasi menjadi lebih baik',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
