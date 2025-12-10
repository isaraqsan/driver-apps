// import 'package:gibas/core/app/color_palette.dart';
// import 'package:gibas/core/app/dimens.dart';
// import 'package:gibas/core/utils/size_config.dart';
// import 'package:gibas/features/master/controller/master_action_controller.dart';
// import 'package:gibas/shared/base_scaffold.dart';
// import 'package:gibas/shared/typography/typography_component.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

// class MasterActionView extends GetView<MasterActionController> {
//   const MasterActionView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorPalette.white,
//       body: GetBuilder(
//         init: MasterActionController(),
//         builder: (controller) {
//           return BaseScaffold(
//             contentMobile: _contentMobile(),
//           );
//         },
//       ),
//     );
//   }

//   Widget _contentMobile() {
//     return controller.obx(
//       (state) {
//         return Center(
//           child: SizedBox(
//             width: SizeConfig.blockSizeHorizontal * 80,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 SvgPicture.asset(
//                   controller.imageState(),
//                   height: Dimens.imageSizelarge250,
//                 ),
//                 if (state == MasterActionState.loading)
//                   const Padding(
//                     padding: EdgeInsets.symmetric(vertical: 10.0),
//                     child: LinearProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(ColorPalette.primary),
//                     ),
//                   ),
//                 TextComponent.textTitle(
//                   controller.title(),
//                   textAlign: TextAlign.center,
//                 ),
//                 Dimens.marginVerticalMedium(),
//                 TextComponent.textBody(
//                   controller.description(),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//       onLoading: const SizedBox(),
//     );
//   }
// }
