import 'dart:io';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:mood_tune/core/api/i_Api_service.dart';
import 'package:path_provider/path_provider.dart';
import '../../presentation/downloaded_song/downloaded_song_controller.dart';

class FileStorage {
  final _dioForDownload = Get.find<IApiService>();

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
      await _dioForDownload.downLoadFile(url, filePath);

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
