import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  @override
  void onInit() {
    listenNotification();
    getToken();
    super.onInit();
  }

  String? token = '';

  void getToken() async {
    token = await FirebaseMessaging.instance.getToken();
    saveToken(token!);
  }

  void saveToken(String token) async {
    await FirebaseFirestore.instance
        .collection('Usertoken')
        .doc('Doctor')
        .set({
      'token': token,
    });
    print(token);
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
        );
      },
    );
  }

  Future<void> sendPushNotifications(String token) async {
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
            'to': token,
          },
        ),
      );
      response;
    } catch (e) {
      e;
    }
  }
}
