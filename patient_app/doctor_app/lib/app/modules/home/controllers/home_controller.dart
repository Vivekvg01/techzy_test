import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  @override
  void onInit() {
    listenNotification();
    super.onInit();
  }

  void listenNotification() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
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
          // actionButtons: [
          //   NotificationActionButton(
          //     key: "ACCEPT",
          //     label: 'Accept Call',
          //     color: Colors.green,
          //     autoDismissible: true,
          //   ),
          //   NotificationActionButton(
          //     key: "REJECT",
          //     label: 'Reject Call',
          //     color: Colors.red,
          //     autoDismissible: true,
          //   )
          // ],
        );
        // AwesomeNotifications().actionStream.listen(
        //   (event) {
        //     if (event.buttonKeyPressed == "REJECT") {
        //       print('call rejected');
        //     } else if (event.buttonKeyPressed == "ACCEPT") {
        //       print('call accepted');
        //     } else {
        //       print('Clicked notification');
        //     }
        //   },
        // );
      },
    );
  }
    Future<void> sendPushNotifications() async {
    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAARoLDuwg:APA91bE_RAxcqAWlq2R069tPIy9onCCXWEB-iD_-PMsoZDWEpF8HXM1ZGLjJmrFMQEZ_xYWZftJVOwTUJOv0C6lTr1viWasGdr0YbYKKAYnKxg4oKrhiUB7msvpE5NxTi0nj8ZHynXzr',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'Incoming Call',
              'title': 'Doctor',
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': 'coGJFSnlR7WNZ-LUzChxcr:APA91bE-X9Y6EZW2JGjOSLMOg9ce6ecQq1MxVUFKRuq-a0tzbvpRvTJJU2jk59sOFw-9iGq4nQVLxsKs5npjVw6kaGZhhTrFYZJZ0vDkx3CdkICBinRcqB2C80m0108vEP-EHYnfO1la',
          },
        ),
      );
      response;
    } catch (e) {
      e;
    }
  }
}
