import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/features/notification/controller/notification_controller.dart';
import 'package:gibas/features/notification/model/notification_model.dart';
import 'package:gibas/shared/base_scaffold.dart';
import 'package:gibas/shared/typography/typography_component.dart';
import 'package:gibas/shared/widgets/shimmer.dart';
import 'package:gibas/shared/widgets/state_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: NotificationController(),
      builder: (controller) {
        return BaseScaffold(
          title: 'Notifikasi',
          usePaddingHorizontal: false,
          contentMobile: _contentMobile(),
          // onTapFab: controller.onNavAdd,
        );
      },
    );
  }

  Widget _contentMobile() {
    return PagedListView<int, NotifItem>(
      pagingController: controller.pagingController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      builderDelegate: PagedChildBuilderDelegate<NotifItem>(
        itemBuilder: (context, item, index) => _notificationCard(item),
        newPageProgressIndicatorBuilder: (_) => _buildShimmerList(),
        noItemsFoundIndicatorBuilder: (_) =>
            StateWidget.emptyData(message: 'Tidak ada Notifikasi'),
        firstPageErrorIndicatorBuilder: (_) => StateWidget.error(
          message: 'Gagal memuat Notifikasi',
          onRetry: () => controller.pagingController.refresh(),
        ),
      ),
    );
  }

  Widget _notificationCard(NotifItem item) {
    final date = item.createdDate != null
        ? DateFormat('dd MMM yyyy, HH:mm').format(item.createdDate!.toLocal())
        : "";

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        shadowColor: Colors.black26,
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            // TODO: Navigate to detail page or open URL
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: ColorPalette.primary.withOpacity(0.1),
                  radius: 22,
                  child: const Icon(
                    Icons.notifications_active,
                    color: ColorPalette.primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextComponent.textTitle(
                        item.textMessage ?? '',
                        bold: true,
                        colors: Colors.black87,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        date,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerList() {
    return Column(
      children: List.generate(
        6,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
          child: ShimmerWidget.rectangularList(itemCount: 1),
        ),
      ),
    );
  }
}
