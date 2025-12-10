import 'package:cached_network_image/cached_network_image.dart';
import 'package:gibas/core/app/color_palette.dart';
import 'package:gibas/core/app/constant.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/domain/models/notification_data.dart';
import 'package:gibas/features/approval/controller/approval_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/features/global/model/resource_response.dart';
import 'package:gibas/features/profile/view/profile_form_view.dart';
import 'package:gibas/shared/base_scaffold.dart';

class ApprovalNotifView extends GetView<ApprovalController> {
  final Resource? member;
  final NotificationPayload? notification;

  const ApprovalNotifView(this.member, {super.key, this.notification});

  @override
  Widget build(BuildContext context) {
    Log.d('[ApprovalNotifView] member: $member');
    Log.d('[ApprovalNotifView] notification: $notification');

    return GetBuilder<ApprovalController>(
      init: ApprovalController(), // <--- inject ke controller
      builder: (controller) {
        return BaseScaffold(
          title: 'Approval',
          usePaddingHorizontal: false,
          contentMobile: _contentMobile(),
        );
      },
    );
  }

  Widget _contentMobile() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          // Profile Card
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorPalette.secondary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: [
                // Avatar
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [ColorPalette.primary, ColorPalette.secondary],
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: ColorPalette.grey,
                    backgroundImage: (member?.imageFoto != null &&
                            member!.imageFoto!.isNotEmpty)
                        ? CachedNetworkImageProvider(
                            '${Constant.baseUrlImage}/${member?.imageFoto!}')
                        : const NetworkImage(
                                'https://avatar.iran.liara.run/public/32')
                            as ImageProvider,
                  ),
                ),
    
                const SizedBox(height: 16),
                Text(
                  notification?.title ?? '',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  notification?.body ?? '',
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.white.withOpacity(0.3)),
                const SizedBox(height: 16),
    
                const SizedBox(height: 24),
                // Edit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await controller.approveAccount(
                          notification?.confirmHash ?? '');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorPalette.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Approve',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: ColorPalette.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
