import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../model/music_api_response.dart';
import '../../repo/i_music_repository.dart';
import '../../services/auth/music_service.dart';
import '../../services/auth/storage_service.dart';

class DetailFetchMusicController extends GetxController {
  //repo
  final IMusicRepo musicRepo = Get.find<IMusicRepo>();

  //music service fo play and stop music
  final MusicService _musicService = Get.find<MusicService>();

  //download service for the download music
  final FileStorage _fileStorage = Get.find<FileStorage>();

  //controller for fetch more if pagination is applied
  final ScrollController musicScrollController = ScrollController();

  //var for fetch music
  int offset = 0;
  final int limit = 30;
  final hasMore = true.obs;
  var result = <ResponseResult>[].obs;
  final isLoadingMusic = false.obs;

  //play music
  void playTrack(String url) {
    _musicService.playMusic(url);
  }

  //stop music
  void stopTrack() {
    _musicService.stopMusic();
  }

  //current track for pause and start audio and error msg if error occur.
  RxString get currentTrack => _musicService.currentTrackUrl;

  RxnString get audioPlayError => _musicService.errorMsgInAudioPlay;

  Future<void> downloadMusicOffline(String url, String fileName) async {
    await _fileStorage.downloadMusicOffline(url, fileName);
  }

  @override
  void onInit() {
    final args = Get.arguments as Map<String, String>;
    final type = args['type'];
    final value = args['value'];

    if (type == 'tag') {
      fetchMusic(fuzzytags: value);
    } else if (type == 'track') {
      fetchMusic(namesearch: value);
    }

    musicScrollController.addListener(() {
      if (musicScrollController.position.pixels >=
              musicScrollController.position.maxScrollExtent - 200 &&
          hasMore.value &&
          !isLoadingMusic.value) {
        if (type == 'tag') {
          fetchMusic(fuzzytags: value);
        } else if (type == 'track') {
          fetchMusic(namesearch: value);
        }
      }
    });

    super.onInit();
  }

  void fetchMusic({String? fuzzytags, String? namesearch}) async {
    isLoadingMusic.value = true;

    try {
      final response = await musicRepo.fetchMusic(
        limit: limit,
        offSet: offset,
        fuzzytags: fuzzytags,
        namesearch: namesearch,
      );

      result.addAll(response.results);
      offset += limit;
      if (response.results.length < limit) hasMore.value = false;
    } catch (e) {
      print("Fetch music failed: $e");
    } finally {
      isLoadingMusic.value = false;
    }
  }
}
