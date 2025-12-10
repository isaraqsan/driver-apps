// import 'package:chairil/core/app/app_config.dart';
// import 'package:chairil/core/app/color_palette.dart';
// import 'package:chairil/core/app/dimens.dart';
// import 'package:chairil/core/app/icons_path.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';

// class ShimmerLogo extends StatelessWidget {
//   const ShimmerLogo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       child: Center(
//         child: Container(
//           padding: const EdgeInsets.all(Dimens.value24),
//           decoration: const BoxDecoration(
//             shape: BoxShape.circle,
//             color: ColorPalette.white,
//           ),
//           child: Shimmer.fromColors(
//             period: const Duration(milliseconds: AppConfig.durationShimmer),
//             highlightColor: ColorPalette.white,
//             baseColor: ColorPalette.shimmer,
//             child: Image.asset(
//               IconsPath.logoTransparent,
//               width: Dimens.imageSizeSmall40,
//               height: Dimens.imageSizeSmall40,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
