import 'package:get/get.dart';
import '../core/api/api_service.dart';
import '../core/api/dio_client.dart';
import '../core/api/i_Api_service.dart';
import '../database/local_db/secure_storage.dart';
import '../presentation/album_page_detail/album_page_controller.dart';
import '../presentation/bottom_nav/nav_bar_controller.dart';
import '../presentation/detail_fetch_music/detail_fetch_music_controller.dart';
import '../presentation/downloaded_song/downloaded_song_controller.dart';
import '../presentation/home_screen/home_controller.dart';
import '../presentation/search/search_controller.dart';
import '../repo/i_music_repository.dart';
import '../repo/music_repo.dart';
import '../services/auth/music_service.dart';
import '../services/auth/storage_service.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlbumPageController>(() => AlbumPageController(), fenix: true);
    Get.lazyPut<IMusicRepo>(() => MusicRepo(Get.find<IApiService>()));
    Get.lazyPut<DioClientService>(() => DioClientService());
    Get.lazyPut<IApiService>(() => ApiService(Get.find<DioClientService>()));
    Get.lazyPut<MusicRepo>(() => MusicRepo(Get.find<IApiService>()));
    Get.lazyPut<NavBarController>(() => NavBarController());
    Get.lazyPut<DioClientService>(() => DioClientService());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SecureStorage>(() => SecureStorage());
    Get.lazyPut<DownloadedMusicController>(() => DownloadedMusicController());
    Get.lazyPut<SearchControllerController>(() => SearchControllerController());
    Get.lazyPut<MusicService>(() => MusicService());
    Get.lazyPut<FileStorage>(() => FileStorage());
    Get.lazyPut<DetailFetchMusicController>(
      () => DetailFetchMusicController(),
      fenix: true,
    );
  }
}
