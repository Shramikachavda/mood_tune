abstract class IApiService{

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});
  Future<dynamic> post(String path , {dynamic data});
  Future<dynamic> put(String path , {dynamic data});
  Future<dynamic> delete(String path , {dynamic data});
  Future<dynamic> downLoadFile(String url, String filepath);




}