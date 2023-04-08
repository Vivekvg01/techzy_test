import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:doctor_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelKey: 'call_channel',
        channelName: 'Call Channel',
        channelDescription: 'channel for calling',
        defaultColor: Colors.redAccent,
        ledColor: Colors.white,
        importance: NotificationImportance.Max,
        channelShowBadge: true,
        locked: true,
        defaultRingtoneType: DefaultRingtoneType.Notification,
      ),
    ],
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
    ),
  );
}

Future<void> backgroundHandler(RemoteMessage message) async {
  String? title = message.notification!.title;
  String? body = message.notification!.body;
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 123,
      channelKey: 'call_channel',
      color: Colors.white,
      title: title,
      body: body,
      category: NotificationCategory.Call,
      wakeUpScreen: true,
      fullScreenIntent: true,
      autoDismissible: false,
      backgroundColor: Colors.orange,
    ),
  );
}
