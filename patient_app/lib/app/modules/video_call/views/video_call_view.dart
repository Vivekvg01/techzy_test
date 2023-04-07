import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import '../controllers/video_call_controller.dart';

class VideoCallView extends GetView<VideoCallController> {
  const VideoCallView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltVideoConference(
      appID: 911922107,
      appSign:
          '2f2fcff54d4fed253d3fd2aa5dc27c31cce877ddd2c070c93fcff837f05efd07',
      conferenceID: Get.arguments[0],
      userID: Get.arguments[1],
      userName: 'userName ${Get.arguments[1]}',
      config: ZegoUIKitPrebuiltVideoConferenceConfig(),
    );
  }
}
