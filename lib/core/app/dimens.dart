import 'package:flutter/material.dart' show EdgeInsets, SizedBox;

class Dimens {
  static const double value4 = 4;
  static const double value6 = 6;
  static const double value8 = 8;
  static const double value10 = 10;
  static const double value12 = 12;
  static const double value14 = 14;
  static const double value16 = 16;
  static const double value18 = 18;
  static const double value20 = 20;
  static const double value22 = 22;
  static const double value24 = 24;
  static const double value26 = 26;
  static const double value28 = 28;
  static const double value30 = 30;
  static const double value32 = 32;
  static const double value34 = 34;
  static const double value36 = 36;
  static const double value38 = 38;
  static const double value40 = 40;
  static const double value42 = 42;
  static const double value44 = 44;
  static const double value46 = 46;
  static const double value48 = 48;
  static const double value50 = 50;
  static const double value52 = 52;
  static const double value56 = 56;
  static const double value58 = 58;
  static const double value60 = 60;
  static const double value100 = 100;

  static const padding2 = EdgeInsets.symmetric(vertical: 2, horizontal: 15);
  static const padding3 = EdgeInsets.symmetric(vertical: 3, horizontal: 15);
  static const padding4 = EdgeInsets.symmetric(vertical: 4, horizontal: 4);
  static const padding5 = EdgeInsets.symmetric(vertical: 5, horizontal: 15);
  static const padding6 = EdgeInsets.symmetric(vertical: 6, horizontal: 6);
  static const padding10 = EdgeInsets.symmetric(vertical: 10, horizontal: 15);
  static const padding20 = EdgeInsets.symmetric(vertical: 20, horizontal: 20);
  static const padding30 = EdgeInsets.symmetric(vertical: 30, horizontal: 20);
  static const paddingBase = EdgeInsets.symmetric(vertical: 5, horizontal: 5);
  static const paddingDetailView = EdgeInsets.symmetric(vertical: 10, horizontal: 15);
  static const paddingTile = EdgeInsets.symmetric(vertical: 8, horizontal: 15);
  static const paddingCard = EdgeInsets.symmetric(vertical: value6, horizontal: value8);
  static const paddingCardListMobile = EdgeInsets.symmetric(vertical: value12, horizontal: value12);
  static const paddingScrollpage = EdgeInsets.symmetric(vertical: 10, horizontal: 20);
  static const paddingFormSectionCard = EdgeInsets.symmetric(vertical: 16, horizontal: 16);

  // * Margin
  static const marginCardListMobile = EdgeInsets.symmetric(vertical: value4, horizontal: value12);
  static const marginForm = EdgeInsets.symmetric(vertical: value12, horizontal: value20);
  static const marginCardMobile = EdgeInsets.symmetric(vertical: 5, horizontal: 15);
  static const marginFilterMobile = EdgeInsets.only(top: 5, bottom: 5, left: 15);
  static const marginContentHorizontal10 = EdgeInsets.symmetric(horizontal: 10);
  static const marginContentHorizontalSmall = EdgeInsets.symmetric(horizontal: 8);
  static const marginContentHorizontal = EdgeInsets.symmetric(horizontal: 16);
  static const marginContentHorizontalOnlyLeft = EdgeInsets.only(left: 16);
  static const marginContentHorizontal20 = EdgeInsets.symmetric(horizontal: 20);
  static const marginContentHorizontal24 = EdgeInsets.symmetric(horizontal: 24);
  static const marginInputField = EdgeInsets.only(bottom: 16);

  static EdgeInsets marginCardList({bool isLast = false}) => const EdgeInsets.symmetric(vertical: value4, horizontal: value12).copyWith(bottom: isLast ? 100 : value4);
  // * Padding
  static const paddingContentS = EdgeInsets.symmetric(vertical: 4, horizontal: 15);
  static const paddingContentExtraSmall2 = EdgeInsets.symmetric(vertical: 2, horizontal: 2);
  static const paddingContentExtraSmall = EdgeInsets.symmetric(vertical: 2, horizontal: 6);
  static const paddingContentSmall1 = EdgeInsets.symmetric(vertical: 8, horizontal: 12);
  static const paddingContentM = EdgeInsets.symmetric(vertical: 8, horizontal: 12);
  static const paddingContentCard = EdgeInsets.symmetric(vertical: 12, horizontal: 20);
  static const paddingContetDialog = EdgeInsets.symmetric(vertical: 20, horizontal: 20);
  static const paddingPage = EdgeInsets.symmetric(vertical: 10, horizontal: 20);
  static const paddingBoundMap = EdgeInsets.symmetric(horizontal: 60);

  static const radius12 = 12.0;
  static const radiusExtraSmall = 4.0;
  static const radiusSmall5 = 5.0;
  static const radiusSmall6 = 6.0;
  static const radiusSmall8 = 8.0;
  static const radiusSmall = 10.0;
  static const radiusSmall12 = 12.0;
  static const radiusMedium = 18.0;
  static const radiusLarge = 20.0;
  static const radiusTextField = 18.0;
  static const radiusContentPage = 40.0;

  // * Textfield
  static const heightTextField = 35.0;

  // * AppBar
  static const heightAppBar = 50.0;

  // * Vertical
  static SizedBox marginVerticalXSmall() => const SizedBox(height: 4);
  static SizedBox marginVerticalSmall() => const SizedBox(height: 6);
  static SizedBox marginVerticalMedium() => const SizedBox(height: 12);
  static SizedBox marginVerticalLarge() => const SizedBox(height: 16);
  static SizedBox marginVerticalXLarge() => const SizedBox(height: 24);
  static SizedBox marginVerticalXXLarge() => const SizedBox(height: 40);
  static SizedBox marginVerticalXXXLarge() => const SizedBox(height: 70);

  // * Horizontal
  static SizedBox marginHorizontalXSmall() => const SizedBox(height: 3);
  static SizedBox marginHorizontalSmall() => const SizedBox(width: 5);
  static SizedBox marginHorizontalMedium() => const SizedBox(width: 10);
  static SizedBox marginHorizontalLarge() => const SizedBox(width: 15);
  static SizedBox marginHorizontalLarge20() => const SizedBox(width: 20);
  static SizedBox marginHorizontalLarge30() => const SizedBox(width: 30);

  static const double imageSizeSmall25 = 25;
  static const double imageSizeSmall40 = 40;
  static const double imageSizeSmall = 60;
  static const double imageSizeMedium = 80;
  static const double imageSizelarge = 100;
  static const double imageSizelarge120 = 120;
  static const double imageSizelarge150 = 150;
  static const double imageSizelarge250 = 250;

  // * Icons Size
  static const double iconSizeSmall = 15;
  static const double iconSizeSmall20 = 20;
  static const double iconSizeSmall25 = 25;
  static const double iconSizeMedium = 30;
  static const double iconSizeLarge = 40;

  // * Button Size
  static const double buttonSizeSmall = 40;
  static const double buttonSizeMedium = 60;
  static const double buttonSizeLarge = 80;
  static const double buttonSizeLarge100 = 100;
  static const double buttonSizeLarge150 = 150;

  // * Shimmer
  static const double heightShimmerText = 16;

  static EdgeInsets marginCard(bool last, {double horizontal = 20, double bottom = 5}) => EdgeInsets.only(top: 5, bottom: last ? 100 : bottom, left: horizontal, right: horizontal);

  // * Map Size
  static const double mapSizeSmall = 250;

  //* Table Size
  static const double widthTableMobileMedium = 350;
  static const double widthTableMobileLarge = 600;

  // * Toast
  static const paddingToast = EdgeInsets.symmetric(vertical: 10, horizontal: 10);
}
