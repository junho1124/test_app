import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/model/item.dart';
import '../../view_model/video_view_model.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({Key? key
  ,required this.item}) : super(key: key);

  final Item item;

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
                children: [
                  Text("video")
                ],
              ),
            ),
          );
        }
    );
  }
}
