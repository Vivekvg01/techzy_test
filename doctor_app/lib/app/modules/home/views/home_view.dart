import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/app/modules/video_chat/views/video_chat_view.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Call patient For diaganosis',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15.0),
            SizedBox(
              height: 30,
              child: ElevatedButton(
                onPressed: () async {
                  Get.to(
                    () => const VideoChatView(),
                    arguments: [conferenceID, userId],
                  );
                  DocumentSnapshot snap = await FirebaseFirestore.instance
                      .collection('Usertoken')
                      .doc('Patient')
                      .get();
                  String? patientToken = snap['token'];
                  controller.sendPushNotifications(patientToken!);
                },
                child: const Text('Call'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
