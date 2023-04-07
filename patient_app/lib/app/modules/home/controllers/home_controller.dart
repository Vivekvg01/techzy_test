import 'dart:convert';
import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_app/app/modules/video_call/views/video_call_view.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  String? conferenceID;
  String? userId;

  @override
  void onInit() {
    listenNotification();
    conferenceID = 'conferenceId';
    userId = Random().nextInt(1000).toString();
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
            )
          ],
        );
        AwesomeNotifications().actionStream.listen(
          (event) {
            if (event.buttonKeyPressed == "REJECT") {
              sendPushNotifications();
            } else if (event.buttonKeyPressed == "ACCEPT") {
              Get.to(
                VideoCallView(),
                arguments: [conferenceID, userId],
              );
            } else {
              print('Clicked notification');
            }
          },
        );
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
              'body': 'Call declined',
              'title': 'Patient',
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to':
                'e2ISZV1hTkiAUmriIzZFA5:APA91bGI09jjDp4UzDvs4u51Gd2VXaZukvA7Su1h0ccwPzaYIaTq31K9EzbeyLYloVF-OukfYxNR0xa8vK2dMn29kyhxEHzpNu43tCALkgKdXxNnidOTBTYz0V9deLc-9pu4HmxO2Ivw',
          },
        ),
      );
      response;
    } catch (e) {
      e;
    }
  }
}
