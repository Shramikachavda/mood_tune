import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  //set data
  Future<void> setData({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  //get data
  Future<String?> getData({required String key}) async {
    return await storage.read(key: key);
  }

  //delete data
  Future<void> deleteData({required String key}) async {
    await storage.delete(key: key);
  }

  //remove all
  Future<void> removeAll() async {
    await storage.deleteAll();
  }


}
