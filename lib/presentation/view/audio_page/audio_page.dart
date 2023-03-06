import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/presentation/view_model/audio_view_model.dart';
import 'package:test_app/presentation/widget/bottom_nav_bar.dart';
import 'package:test_app/presentation/widget/loading_indicator.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({
    Key? key,
    required this.url,
  }) : super(key: key);
  static const String path = "/AudioPage";

  final String url;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioViewModel>(
        init: AudioViewModel(url: url),
        builder: (vm) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("오디오 페이지"),
              centerTitle: true,
            ),
            bottomNavigationBar: const BottomNavBar(),
            body: Obx(() => vm.isLoaded.isTrue
                ? Card(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: context.width,
                              height: 6,
                              color: Colors.black26,
                            ),
                            Obx(() => Container(
                                  width: context.width * vm.progress.value,
                                  height: 7,
                                  color: context.theme.primaryColor,
                                ))
                          ],
                        ),
                        Obx(() => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "${vm.current.value.inMinutes}:${(vm.current.value.inSeconds.remainder(60).toString().padLeft(2, "0"))}"),
                                Text(
                                    "${(vm.end - vm.current.value).inMinutes}: ${(vm.end - vm.current.value).inSeconds.remainder(60).toString().padLeft(2, "0")}")
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                onPressed: () => vm.toStart(),
                                icon: const Icon(Icons.skip_previous_outlined)),
                            IconButton(
                                onPressed: () => vm.back(),
                                icon: const Icon(Icons.replay_5)),
                            IconButton(
                                onPressed: () => vm.start(),
                                icon: Obx(() => Icon(vm.isPlaying.isTrue
                                    ? Icons.pause
                                    : Icons.play_circle))),
                            IconButton(
                                onPressed: () => vm.forward(),
                                icon: const Icon(Icons.forward_5)),
                            IconButton(
                                onPressed: () => vm.toEnd(),
                                icon: const Icon(Icons.skip_next_outlined)),
                          ],
                        )
                      ],
                    ))
                : const LoadingIndicator()),
          );
        });
  }
}
