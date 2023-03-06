import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/presentation/widget/loading_indicator.dart';
import 'package:video_player/video_player.dart';

import '../../view_model/video_view_model.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({Key? key, required this.url}) : super(key: key);
  static const String path = "/VideoPage";

  final String url;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoViewModel>(
        init: VideoViewModel(url: url),
        builder: (vm) {
          return Obx(
            () => Scaffold(
                appBar: vm.isRotate.isFalse
                    ? AppBar(
                        title: const Text("비디오 페이지"),
                        centerTitle: true,
                      )
                    : null,
                backgroundColor: Colors.black,
                body: vm.isLoaded.isTrue
                    ? GestureDetector(
                        onTap: () => vm.optionOpened.toggle(),
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: vm.aspectRatio,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                VideoPlayer(vm.controller),
                                Positioned(
                                  child: AnimatedOpacity(
                                    opacity: vm.optionOpened.isTrue ? 1 : 0,
                                    duration:
                                        const Duration(milliseconds: 300),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                            onPressed: () => vm.back(),
                                            icon: Icon(
                                              Icons.fast_rewind_outlined,
                                              size: 48,
                                              color: Colors.white,
                                            )),
                                        IconButton(
                                            onPressed: () => vm.playAndStop(),
                                            icon: Icon(
                                              vm.isPlaying.isTrue
                                                  ? Icons.pause
                                                  : Icons.play_circle,
                                              size: 48,
                                              color: Colors.white,
                                            )),
                                        IconButton(
                                            onPressed: () => vm.forward(),
                                            icon: Icon(
                                              Icons.fast_forward_outlined,
                                              size: 48,
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: IconButton(
                                        onPressed: () => vm.fullScreen(),
                                        icon: Icon(
                                          vm.isRotate.isTrue
                                              ? Icons.fullscreen_exit
                                              : Icons.fullscreen,
                                          size: 24,
                                          color: Colors.white,
                                        )))
                              ],
                            ),
                          ),
                        ),
                      )
                    : const LoadingIndicator()),
          );
        });
  }
}
