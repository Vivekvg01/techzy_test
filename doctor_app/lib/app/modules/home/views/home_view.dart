import 'dart:math';
import 'package:doctor_app/app/modules/video_chat/views/video_chat_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.onInit();
    String conferenceID = 'conferenceId';
    String userId = Random().nextInt(1000).toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor App'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                Get.to(
                  const VideoChatView(),
                  arguments: [conferenceID, userId],
                );
                controller.sendPushNotifications();
              },
              child: const Text('Call Patient'),
            ),
          ],
        ),
      ),
    );
  }
}
