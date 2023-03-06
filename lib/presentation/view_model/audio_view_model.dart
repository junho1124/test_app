import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class AudioViewModel extends GetxController {
  AudioViewModel({required this.url});

  final String url;
  late final Duration end;
  final Rx<Duration> current = const Duration(seconds: 0).obs;
  final RxDouble progress = 0.0.obs;
  RxBool isPlaying = false.obs;
  RxBool isBuffering = false.obs;

  final AudioPlayer audioPlayer = AudioPlayer();

  RxBool isLoaded = false.obs;

  @override
  void onInit() async {
    await audioPlayer.setSourceUrl(url);
    audioPlayer.setPlayerMode(PlayerMode.mediaPlayer);
    end = (await audioPlayer.getDuration())!;
    audioPlayer.setReleaseMode(ReleaseMode.stop);
    addAudioListener();
    isLoaded.value = true;
    super.onInit();
  }

  void start() {
    if (isPlaying.isTrue) {
      audioPlayer.pause();
    } else {
      audioPlayer.resume();
    }
    isPlaying.toggle();
  }

  void toStart() async {
    await audioPlayer.seek(Duration.zero);
    await audioPlayer.resume();
    isPlaying.value = true;
  }

  void toEnd() async {
    await audioPlayer.seek(end);
    await audioPlayer.pause();
    isPlaying.value = false;
  }

  void back() async {
    await audioPlayer.seek(current.value - const Duration(seconds: 15));
  }

  void forward() async {
    await audioPlayer.seek(current.value + const Duration(seconds: 15));
  }

  void addAudioListener() {
    audioPlayer.onPositionChanged.listen((event) {
      current.value = event;
      progress.value = event.inSeconds / end.inSeconds;
    });
    audioPlayer.onPlayerComplete.listen((event) {
      isPlaying.value = false;
    });
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
