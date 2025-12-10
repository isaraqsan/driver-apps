import 'package:cached_network_image/cached_network_image.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/constant/icons_path.dart';
import 'package:gibas/core/app/dimens.dart';
import 'package:gibas/features/approval/controller/list_approval_controller.dart';
import 'package:gibas/features/global/model/resource_response.dart';
import 'package:gibas/features/member/controller/member_controller.dart';
import 'package:gibas/features/member/model/member.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/component/component.dart';
import 'package:gibas/shared/typography/_input_field.dart';
import 'package:gibas/shared/typography/_text_component.dart';
import 'package:gibas/shared/widgets/chip_button_horizontal.dart';
import 'package:gibas/shared/widgets/shimmer.dart';
import 'package:gibas/shared/widgets/state_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ListApprovalView extends GetView<ListApprovalController> {
  const ListApprovalView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ListApprovalController(),
      builder: (controller) {
        return BaseScaffold(
          title: 'List Approval',
          usePaddingHorizontal: false,
          contentMobile: _contentMobile(),
          // onTapFab: controller.onNavAdd,
        );
      },
    );
  }

  Widget _contentMobile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: Dimens.marginContentHorizontal,
          child: InputField(
            hint: 'Cari anggota',
            prefixIcon: CupertinoIcons.search,
            onChanged: controller.onSearchChanged,
          ),
        ),
        Dimens.marginVerticalMedium(),
        Flexible(
          child: PagedListView<int, Resource>(
              shrinkWrap: true,
              pagingController: controller.pagingController,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.zero,
              builderDelegate: PagedChildBuilderDelegate<Resource>(
                itemBuilder: (_, item, index) => _cardOutlet(item),
                firstPageProgressIndicatorBuilder: (_) => _buildShimmerList(),
                newPageProgressIndicatorBuilder: (_) => const Padding(
                  padding: EdgeInsets.all(12),
                  child: CupertinoActivityIndicator(),
                ),
                noItemsFoundIndicatorBuilder: (context) =>
                    StateWidget.emptyData(fitheight: true),

                firstPageErrorIndicatorBuilder: (context) =>
                    StateWidget.error(message: "Gagal memuat data, coba lagi"),

                newPageErrorIndicatorBuilder: (context) => StateWidget.error(
                    message: "Gagal memuat halaman berikutnya"),
              )),
        ),
      ],
    );
  }

  Widget _cardOutlet(Resource member) {
    return InkWell(
      onTap: () {
        controller.goToApproval(member);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 4, top: 4, left: 16, right: 16),
        padding: Dimens.paddingCardListMobile,
        decoration: Component.shadow(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  imageUrl: IconsPath.avatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Dimens.marginHorizontalLarge(),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextComponent.textTitle(
                    '${member.fullName}',
                    bold: true,
                    colors: ColorPalette.white,
                  ),
                  Dimens.marginVerticalSmall(),
                  TextComponent.textTitle(
                    '${member.telepon}',
                    colors: ColorPalette.white,
                  ),
                  Dimens.marginVerticalSmall(),
                  TextComponent.textTitle(
                    '${member.jenjang?.name ?? '-'} - ${member.jabatan?.name ?? ''}',
                    colors: ColorPalette.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(12),
      itemCount: 6,
      itemBuilder: (context, index) => ShimmerWidget.rectangularList(
        itemCount: 1,
      ),
    );
  }
}
