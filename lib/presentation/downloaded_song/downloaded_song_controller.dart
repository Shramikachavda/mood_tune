import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class DownloadedMusicController extends GetxController {
  final songs = <File>[].obs;
  final player = AudioPlayer();
  final isPlaying = false.obs;
  final currentSong = Rxn<File>();

  @override
  void onInit() {
    super.onInit();
    loadDownloadedSongs();
  }

  //load songs
  Future<void> loadDownloadedSongs() async {
    final dir = await getApplicationDocumentsDirectory();
    final files =
        Directory(dir.path)
            .listSync()
            .where((item) => item is File && item.path.endsWith('.mp3'))
            .map((item) => item as File)
            .toList();
    songs.assignAll(files);
  }

  //play song
  Future<void> playSong(File file) async {
    try {
      currentSong.value = file;
      isPlaying.value = true;
      await player.setFilePath(file.path);
      await player.play();
    } catch (e) {
      Get.snackbar("Error", "Failed to play the file: $e" ,

        backgroundColor: Color(0xffCABBEf).withValues(alpha: 0.8),
      ) ;
    }
  }

  //stop song
  Future<void> stopSong() async {
    currentSong.value = null;
    isPlaying.value = false;
    await player.stop();
  }

  //get path
  Future<String> getAppDownloadPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<void> deleteDownloadedMusic(String fileName) async {
    try {
      final dirPath = await getAppDownloadPath();
      final filePath = "$dirPath/$fileName.mp3";

      final file = File(filePath);

      if (await file.exists()) {
        await file.delete();
        Get.snackbar("Delete Complete", "Deleted file: $fileName" ,
          backgroundColor: Color(0xffCABBEf).withValues(alpha: 0.8),

        );
        print("File deleted: $filePath");
      } else {
        Get.snackbar("Delete Failed", "File not found: $fileName" ,

          backgroundColor: Color(0xffCABBEf).withValues(alpha: 0.8),
        );
        print("File not found: $filePath");
      }
    } catch (e) {
      print("Error deleting file: $e");
      Get.snackbar("Delete Failed", e.toString() ,
        backgroundColor: Color(0xffCABBEf).withValues(alpha: 0.8),
      );
    }
  }

  //confirm dialog before delete
  Future<void> confirmAndDelete(String fileName) async {
    final result = await Get.defaultDialog<bool>(
      title: "Delete File",
      middleText: "Are you sure you want to delete $fileName?",
      textConfirm: "Yes",
      textCancel: "No",
      onConfirm: () {
        Get.back(result: true);
      },
      onCancel: () {
        Get.back(result: false);
      },
    );

    if (result == true) {
      await deleteDownloadedMusic(fileName);
    }
  }
}
