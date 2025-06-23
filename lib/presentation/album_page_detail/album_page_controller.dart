import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import '../../model/album_song_by_artist.dart';
import '../../repo/i_music_repository.dart';
import '../downloaded_song/downloaded_song_controller.dart';

class AlbumPageController extends GetxController {
  //music repo
  final IMusicRepo musicRepo = Get.find<IMusicRepo>();

  //artist name for fetch api
 var name = "";

  //audioPlayer obj
  final player = AudioPlayer();
  final errorMsgInAudioPlay = RxnString();
  final errorMsgInStopMusic = RxnString();

  //current track for pause and stat audio
  final currentTrackUrl = ''.obs;

  //scroller controller for app bar
  final ScrollController controller = ScrollController();
  final showAppBar = false.obs; //RxBool show = false.obs;

  @override
  void onInit() {
    //get string arg
    //  artistName = Get.arguments as String;
    final data = Get.arguments as Map<String, String>;
    final type = data['type'];
    final value = data['value'] ?? '';
    name = value;
    if(type == 'albums'){
      fetchArtistAlbum(albumName: value);
    }else{
      fetchArtistAlbum(name: value);
    }

    //add listener
    controller.addListener(() {
      showAppBar.value = controller.offset > 300.h;
    });
    super.onInit();
  }

  //for song fetch
  final albums = Rxn<SongFetchByArtistName>();
  final isLoading = false.obs;
  final errorMsg = RxnString();

  //fetch artist by name from home page
  Future<void> fetchArtistAlbum({String? name, String? albumName}) async {
    try {
      isLoading.value = true;
      errorMsg.value = null;
      final data = await musicRepo.fetchTracksByArtistName(
        albumName: albumName,
        name: name,
      );
      print("type");
      print(albums.value.runtimeType);
      albums.value = data;
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMsg.value = e.toString();
      print(e.toString());
    }
  }

  //play music
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

  //stop music
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

  final Dio dio = Dio();

  Future<String> getAppDownloadPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<void> downloadMusicOffline(String url, String fileName) async {
    try {
      final dirPath = await getAppDownloadPath();
      final filePath = "$dirPath/$fileName.mp3";

      // Create folder if not exists
      await Directory(dirPath).create(recursive: true);

      Get.snackbar(
        "Preparing Download",
        "Getting your file ready...",
        backgroundColor: Color(0xffCABBEf).withValues(alpha: 0.8),
      );

      // Download the file
      await dio.download(url, filePath);

      Get.snackbar(
        "Download Complete",
        "Downloaded successfully. Find it in your Downloads.",
        backgroundColor: Color(0xffCABBEf).withValues(alpha: 0.8),
      );
      Get.find<DownloadedMusicController>().loadDownloadedSongs();
      print("File downloaded to: $filePath");
    } catch (e) {
      print("Error during download: $e");
      Get.snackbar("Download Failed", e.toString());
    }
  }
}
