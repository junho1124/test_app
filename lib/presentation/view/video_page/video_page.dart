import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view_model/video_view_model.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({Key? key, required this.url}) : super(key: key);
  static const String path = "/VideoPage";

  final String url;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoViewModel>(
        init: VideoViewModel(),
        builder: (vm) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("비디오 페이지"),
              centerTitle: true,
            ),
            body: Container(
              child: Column(
                children: [Text("video")],
              ),
            ),
          );
        });
  }
}
