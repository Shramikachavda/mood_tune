import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class MusicService {
  final AudioPlayer player = AudioPlayer();

  // Current playing track URL
  final RxString currentTrackUrl = ''.obs;

  // Error messages for UI feedback
  final RxnString errorMsgInAudioPlay = RxnString();
  final RxnString errorMsgInStopMusic = RxnString();

  /// Play music from a given URL
  Future<void> playMusic(String url) async {
    try {
      errorMsgInAudioPlay.value = null;
      currentTrackUrl.value = url;
      await player.setUrl(url);
      await player.play();
    } catch (e) {
      errorMsgInAudioPlay.value = e.toString();
      print("Error playing audio: $e");
    }
  }

  /// Stop the currently playing music
  Future<void> stopMusic() async {
    try {
      errorMsgInStopMusic.value = null;
      currentTrackUrl.value = '';
      await player.stop();
    } catch (e) {
      errorMsgInStopMusic.value = e.toString();
      print("Error stopping audio: $e");
    }
  }
}
