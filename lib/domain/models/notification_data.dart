import 'package:onesignal_flutter/onesignal_flutter.dart';

class NotificationPayload {
  final String? title;
  final String? body;
  final String type;
  final String? confirmHash;
  final int? jenjangId;

  NotificationPayload({
    this.title,
    this.body,
    required this.type,
    this.confirmHash,
    this.jenjangId,
  });

  factory NotificationPayload.fromNotification(OSNotification notif) {
    final data = notif.additionalData ?? {};
    return NotificationPayload(
      title: notif.title,
      body: notif.body,
      type: data['type'] ?? '',
      confirmHash: data['confirm_hash'],
      jenjangId: data['jenjang_id'],
    );
  }
}
