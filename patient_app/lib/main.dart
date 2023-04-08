import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/app/modules/home/controllers/home_controller.dart';
import 'package:patient_app/firebase_options.dart';
import 'app/routes/app_pages.dart';

void main() async {
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
        defaultRingtoneType: DefaultRingtoneType.Ringtone,
      ),
    ],
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
    ),
  );
  FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
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
    actionButtons: [
      NotificationActionButton(
        key: "ACCEPT",
        label: 'Accept Call',
        color: Colors.green,
        autoDismissible: true,
      ),
      NotificationActionButton(
        key: "REJECT",
        label: 'Reject Call',
        color: Colors.red,
        autoDismissible: true,
      ),
    ],
  );
  AwesomeNotifications().actionStream.listen(
    (event) async {
      print(event);
      if (event.buttonKeyPressed == "REJECT") {
        final homeController = Get.put(HomeController());
        DocumentSnapshot snap = await FirebaseFirestore.instance
            .collection('Usertoken')
            .doc('Doctor')
            .get();
        String? doctorToken = snap['token'];
        homeController.sendPushNotifications(doctorToken!);
      } else if (event.buttonKeyPressed == "ACCEPT") {
        final homeController = Get.put(HomeController());
        homeController.onAcceptCall();
      } else {
        print('Clicked notification');
      }
    },
  );
}
