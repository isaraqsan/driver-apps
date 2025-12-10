import 'package:flutter/material.dart';
import 'package:gibas/core/app/theme.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/view/coming_soon_widget.dart';

class ComingSoonView extends StatelessWidget {
  const ComingSoonView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      usePaddingHorizontal: false,
      contentMobile: contentMobile(),
    );
  }

  Widget contentMobile() {
    return Container(
      color: ColorPalette.white,
      height: double.infinity,
      width: double.infinity,
      child: const ComingSoonWidget(),
    );
  }
}
