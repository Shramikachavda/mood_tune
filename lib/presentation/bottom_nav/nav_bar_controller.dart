import 'package:get/get.dart';

import '../../repo/music_repo.dart';

class NavBarController extends GetxController {
  final currentIndex = 0.obs;
  final maxIndex = 4;

  @override
  void onInit() {

 //Get.find<MusicRepo>().fetchTracksByArtistName("both");
 //   Get.find<MusicRepo>().fetchMusicInfo();
    super.onInit();
  }

  void updateIndex(int index) {
    try {
      if (index < maxIndex && index >= 0) {
        currentIndex.value = index;
        print(currentIndex.value);
      } else {
        throw Exception("index out of bound");
      }
    } catch (e) {
      print(e.toString());
      throw Exception("Something went wrong");
    }
  }
}
