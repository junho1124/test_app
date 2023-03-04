import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/data/model/item.dart';
import 'package:test_app/presentation/view_model/audio_view_model.dart';

class AudioPage extends StatelessWidget {
  const AudioPage({Key? key,
    required this.item,
  }) : super(key: key);
  static const String path = "/AudioPage";

  final Item item;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioViewModel>(
      init: AudioViewModel(),
      builder: (vm) {
        return Scaffold(
          appBar: AppBar(
            title: Text("오디오 페이지"),
            centerTitle: true,
          ),
          body: Container(
            child: Column(
              children: [
                Text("audio")
              ],
            ),
          ),
        );
      }
    );
  }
}
