/*
import 'package:get/get.dart';
import '../database/local_db/secure_storage.dart';
import '../repo/i_music_repository.dart';
import '../repo/music_repo.dart';
import 'api/api_service.dart';
import 'api/i_Api_service.dart';
import 'api/dio_client.dart';


*/
/*| GetIt                                 | GetX                     |
| ------------------------------------- | ------------------------ |
| `registerSingleton<T>(instance)`      | `Get.put(instance)`      |
| `registerLazySingleton<T>(() => T())` | `Get.lazyPut(() => T())` |
| `getIt<T>()`                          | `Get.find<T>()`          |*//*



//final getIt = GetIt.instance;

void setUp() {
  //secure storage

  //getIt.registerSingleton<SecureStorage>(SecureStorage());
  Get.put<SecureStorage>(SecureStorage());

  // for api
  //getIt.registerLazySingleton<DioClientService>(() => DioClientService());
  Get.lazyPut<DioClientService>(() => DioClientService(),);


//  getIt.registerLazySingleton<IApiService>(() => ApiService(getIt<DioClientService>()),);
  Get.lazyPut<IApiService>(() => ApiService(Get.find<DioClientService>()));


 // getIt.registerLazySingleton<IMusicRepo>(() => MusicRepo(getIt<IApiService>()),);
  Get.lazyPut<IMusicRepo>(() => MusicRepo(Get.find<IApiService>()));
}
*/
