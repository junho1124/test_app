import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoViewModel extends GetxController {
  VideoViewModel({required this.url});

  RxBool isRotate = false.obs;
  RxBool isLoaded = false.obs;
  RxBool isPlaying = false.obs;
  RxBool optionOpened = false.obs;

  final String url;

  late final double aspectRatio;
  late final VideoPlayerController controller;

  @override
  void onInit() async {
    controller = VideoPlayerController.network(url);
    await controller.initialize();
    controller
      ..setVolume(1)
      ..play();
    aspectRatio = controller.value.aspectRatio;
    isLoaded.value = true;
    isPlaying.value = true;
    super.onInit();
  }

  playAndStop() {
    if (isPlaying.isTrue) {
      controller.pause();
    } else {
      controller.play();
    }
    isPlaying.toggle();
  }

  void fullScreen() {
    isRotate.toggle();
    if (isRotate.isTrue) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  void back() async {
    await controller
        .seekTo(controller.value.position - const Duration(seconds: 15));
  }

  void forward() async {
    await controller
        .seekTo(controller.value.position + const Duration(seconds: 15));
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
