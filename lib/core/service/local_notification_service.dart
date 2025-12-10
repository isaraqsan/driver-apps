// import 'dart:async';
// import 'package:gibas/core/utils/log.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:gibas/domain/models/received_notification.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

// final StreamController<ReceivedNotification> didReceiveLocalNotificationStream = StreamController<ReceivedNotification>.broadcast();

// final StreamController<String?> selectNotificationStream = StreamController<String?>.broadcast();

// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
//   if (notificationResponse.input?.isNotEmpty ?? false) {
//   }
// }

// class LocalNotificationService extends GetxService {
//   static int id = 0;

//   String? selectedNotificationPayload;

//   static const String urlLaunchActionId = 'id_1';
//   static const String navigationActionId = 'id_3';
//   static const String darwinNotificationCategoryText = 'textCategory';
//   static const String darwinNotificationCategoryPlain = 'plainCategory';

//   Future<void> setup() async {
//     //* Local Notification
//     const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

//     final List<DarwinNotificationCategory> darwinNotificationCategories = <DarwinNotificationCategory>[
//       DarwinNotificationCategory(
//         darwinNotificationCategoryText,
//         actions: <DarwinNotificationAction>[
//           DarwinNotificationAction.text(
//             'text_1',
//             'Action 1',
//             buttonTitle: 'Send',
//             placeholder: 'Placeholder',
//           ),
//         ],
//       ),
//       DarwinNotificationCategory(
//         darwinNotificationCategoryPlain,
//         actions: <DarwinNotificationAction>[
//           DarwinNotificationAction.plain('id_1', 'Action 1'),
//           DarwinNotificationAction.plain(
//             'id_2',
//             'Action 2 (destructive)',
//             options: <DarwinNotificationActionOption>{
//               DarwinNotificationActionOption.destructive,
//             },
//           ),
//           DarwinNotificationAction.plain(
//             navigationActionId,
//             'Action 3 (foreground)',
//             options: <DarwinNotificationActionOption>{
//               DarwinNotificationActionOption.foreground,
//             },
//           ),
//           DarwinNotificationAction.plain(
//             'id_4',
//             'Action 4 (auth required)',
//             options: <DarwinNotificationActionOption>{
//               DarwinNotificationActionOption.authenticationRequired,
//             },
//           ),
//         ],
//         options: <DarwinNotificationCategoryOption>{
//           DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
//         },
//       )
//     ];

//     final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
//       requestAlertPermission: false,
//       requestBadgePermission: false,
//       requestSoundPermission: false,
//       notificationCategories: darwinNotificationCategories,
//     );
//     final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsDarwin,
//       macOS: initializationSettingsDarwin,
//     );
//     await flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
//         onRouteNotification(notificationResponse.payload ?? '');
//         switch (notificationResponse.notificationResponseType) {
//           case NotificationResponseType.selectedNotification:
//             selectNotificationStream.add(notificationResponse.payload);
//             break;
//           case NotificationResponseType.selectedNotificationAction:
//             if (notificationResponse.actionId == navigationActionId) {
//               selectNotificationStream.add(notificationResponse.payload);
//             }
//             break;
//         }
//       },
//       onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//     );
//   }

//   static Future<void> showNotification(dynamic title, dynamic body, {String? playload}) async {
//     const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
//       'sakti',
//       'sakti',
//       channelDescription: 'sakti channel description',
//       importance: Importance.max,
//       priority: Priority.max,
//       ticker: 'ticker',
//     );
//     const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
//     await flutterLocalNotificationsPlugin.show(id++, title, body, notificationDetails, payload: playload);
//   }

//   void onRouteNotification(String payload) {
//     Log.v(payload, tag: runtimeType.toString());
//   }
// }
