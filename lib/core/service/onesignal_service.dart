import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gibas/core/utils/log.dart';
import 'package:gibas/domain/models/notification_data.dart';
import 'package:gibas/features/approval/view/approval_notif_view.dart';
import 'package:gibas/features/approval/view/approval_view.dart';
import 'package:gibas/features/approval/view/list_approval_view.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:gibas/core/service/env_service.dart';

class OnesignalService {
  Future<void> setup() async {
    Log.d("Setting up OneSignal...");

    // ganti ke warning saja biar tidak terlalu banyak log bawaan OneSignal
    OneSignal.Debug.setAlertLevel(OSLogLevel.none);

    OneSignal.initialize(EnvService().onesignalAppId);
    OneSignal.Notifications.clearAll();

    // monitor subscription state (optional)
    OneSignal.User.pushSubscription.addObserver((state) {
      Log.d("🔔 OneSignal OptedIn: ${OneSignal.User.pushSubscription.optedIn}");
      Log.d("🔔 OneSignal ID: ${OneSignal.User.pushSubscription.id}");
    });

    // listener untuk notif masuk saat app foreground
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      final notif = event.notification;
      final data = notif.additionalData;
      Log.d("📥 Notif Foreground: ${notif.title} - ${notif.body}");
      if (data != null) Log.d("🔑 Data: $data");
      // event.preventDefault(); // uncomment kalau tidak mau notif tampil
    });

    // listener kalau notif diklik
    OneSignal.Notifications.addClickListener((event) {
      final payload = NotificationPayload.fromNotification(event.notification);
      debugPrint("👆 NOTIF DIKLIK: ${payload.title} - ${payload.body}");
      debugPrint("🔑 Data: type=${payload.type}, hash=${payload.confirmHash}");

      if (payload.type == 'account_approval') {
        Get.to(() => const ListApprovalView());
      }
    });

    OneSignal.InAppMessages.paused(true);
    OneSignal.Notifications.requestPermission(true);
  }

  Future<void> setExternalId(String externalId) async {
    try {
      await OneSignal.User.pushSubscription.optIn(); // ✅ aktifkan notif lagi
      await OneSignal.login(externalId);
      Log.d("✅ OneSignal external_id set: $externalId");
    } catch (e) {
      Log.d("❌ Failed to set OneSignal external_id: $e");
    }
  }

  Future<void> clearExternalId() async {
    try {
      await OneSignal.logout();
      await Future.delayed(const Duration(milliseconds: 300));
      await OneSignal.User.pushSubscription.optOut(); // ❌ stop notif
      Log.d("✅ OneSignal external_id cleared & push disabled");
    } catch (e) {
      Log.d("❌ Failed to clear OneSignal external_id: $e");
    }
  }
}
