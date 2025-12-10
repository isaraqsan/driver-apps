import 'package:flutter/material.dart';
import 'package:gibas/core/app/app_config.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/core/utils/size_config.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget {
  Widget attendanceLoading() {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: AppConfig.durationShimmer),
      highlightColor: ColorPalette.white,
      baseColor: ColorPalette.shimmer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: SizeConfig.blockSizeVertical * 30,
              width: SizeConfig.blockSizeHorizontal * 100,
              color: ColorPalette.shimmer,
            ),
            Dimens.marginVerticalLarge(),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    height: 70,
                    decoration: BoxDecoration(
                        color: ColorPalette.shimmer,
                        borderRadius: BorderRadius.circular(10)),
                    width: SizeConfig.blockSizeHorizontal * 100,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget loadingListWithPhoto() {
    return SingleChildScrollView(
      child: Shimmer.fromColors(
        period: const Duration(milliseconds: AppConfig.durationShimmer),
        highlightColor: ColorPalette.white,
        baseColor: ColorPalette.shimmer,
        child: Padding(
          padding: Dimens.padding10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              10,
              (index) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: Dimens.imageSizelarge,
                      width: Dimens.imageSizelarge,
                      decoration: BoxDecoration(
                          color: ColorPalette.shimmer,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  Dimens.marginHorizontalMedium(),
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: ColorPalette.shimmer,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: ColorPalette.shimmer,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          height: 20,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: ColorPalette.shimmer,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget rectangularList({int itemCount = 5}) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: AppConfig.durationShimmer),
      highlightColor: ColorPalette.white,
      baseColor: ColorPalette.shimmer,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemCount,
        padding: Dimens.padding10,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: ColorPalette.shimmer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail
                Container(
                  width: 100,
                  height: 80,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorPalette.shimmer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 14,
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: ColorPalette.shimmer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        Container(
                          height: 14,
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: ColorPalette.shimmer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        Container(
                          height: 12,
                          width: 100,
                          decoration: BoxDecoration(
                            color: ColorPalette.shimmer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ],
                    ),
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
