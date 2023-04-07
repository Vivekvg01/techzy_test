import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/video_chat/bindings/video_chat_binding.dart';
import '../modules/video_chat/views/video_chat_view.dart';

// ignore_for_file: constant_identifier_names

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_CHAT,
      page: () => const VideoChatView(),
      binding: VideoChatBinding(),
    ),
  ];
}
