// import 'dart:developer';

// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:awesome_notifications_fcm/awesome_notifications_fcm.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class FCMService extends GetxService {
//   @override
//   void onInit() {
//     super.onInit();
//     AwesomeNotifications().requestPermissionToSendNotifications();
//     AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//           channelKey: 'high_importance_channel',
//           channelName: 'High Importance Notifications',
//           channelDescription:
//               'This is a channel for high importance notifications',
//           importance: NotificationImportance.High,
//           defaultColor: Colors.orange,
//           ledColor: Colors.orange,
//         ),
//       ],
//     );
//     AwesomeNotifications()
//         .setListeners(onActionReceivedMethod: FCMService.onNotificationAction);
//     initializeRemoteNotifications(debug: true);
//   }

//   static Future<void> onNotificationAction(
//       ReceivedAction receivedNotification) async {
//     try {
//       if (receivedNotification.channelKey == 'high_importance_channel') {
//         if (receivedNotification.buttonKeyPressed == 'SEE_ORDER') {
//           log('Notification action received');
//           // NAVIGATE TO SPECEFIC ORDER
//           Get.toNamed('/user-orders');
//         }
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//   }

//   static Future<void> initializeRemoteNotifications(
//       {required bool debug}) async {
//     await Firebase.initializeApp();
//     await AwesomeNotificationsFcm().initialize(
//         onFcmSilentDataHandle: mySilentDataHandle,
//         onFcmTokenHandle: myFcmTokenHandle,
//         onNativeTokenHandle: myNativeTokenHandle,
//         licenseKeys: null,
//         debug: debug);
//   }

//   @pragma("vm:entry-point")
//   static Future<void> mySilentDataHandle(FcmSilentData silentData) async {
//     if (kDebugMode) {
//       log('"SilentData": ${silentData.toString()}');
//     }

//     await AwesomeNotifications().createNotification(
//       actionButtons: [
//         NotificationActionButton(
//           key: 'SEE_ORDER',
//           label: 'Voir la commande',
//         ),
//       ],
//       content: NotificationContent(
//         id: 10,
//         channelKey: 'high_importance_channel',
//         title: silentData.data?['title'],
//         body: silentData.data?['body'],
//       ),
//     );
//   }

//   @pragma("vm:entry-point")
//   static Future<void> myFcmTokenHandle(String token) async {
//     await GetStorage().write("fcm_key", token);
//     debugPrint('FCM Token:"$token"');
//   }

//   @pragma("vm:entry-point")
//   static Future<void> myNativeTokenHandle(String token) async {
//     debugPrint('Native Token:"$token"');
//   }

//   Future<String> getFirebaseMessagingToken() async {
//     String firebaseAppToken = '';
//     if (await AwesomeNotificationsFcm().isFirebaseAvailable) {
//       try {
//         firebaseAppToken =
//             await AwesomeNotificationsFcm().requestFirebaseAppToken();
//       } catch (e) {
//         printError(info: '$e');
//       }
//     } else {
//       printError(info: 'Firebase is not available on this project');
//     }
//     return firebaseAppToken;
//   }
// }
