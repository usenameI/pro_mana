
import 'package:dio/dio.dart';
///设置全局api使用的参数
class apiConfig{
  ///token
  static String token='';
  ///接口使用的地址
  static String internetAddress='';
  ///图片显示使用的地址
  static String imageInter='';
}

///网络请求封装
class apiMana {
    static Future get(
      {required String path, Map<String, dynamic>? queryParameters}) async {
    final dio = Dio();
    final res = await dio.get(apiConfig.internetAddress+path,
        queryParameters: queryParameters,
        options: Options(headers: {'Authorization': apiConfig.token})
        );
    return res.data;
  }

  static Future post({required String path, Map? data}) async {
    final dio = Dio();
    final res = await dio.post('${apiConfig.internetAddress}$path',
        data: data, options: Options(headers: {'Authorization': apiConfig.token}));
    print('log__apiMana_post_返回数据:${res.data}');
    return res.data;
  }

  static Future delete({required String path}) async {
    final dio = Dio();
    final res = await dio.delete('${apiConfig.internetAddress}$path',
        options: Options(headers: {'Authorization': apiConfig.token}));
    return res.data;
  }

  // static Future uploadFile(
  //     {required fileBytes, required fileName, required path}) async {
  //   FormData formData = FormData.fromMap({
  //     'file': MultipartFile.fromBytes(fileBytes!, filename: fileName),
  //   });
  //   final dio = Dio();
  //   Response response = await dio.post(
  //     path, // 替换为您的服务器 URL
  //     data: formData,
  //   );
  //   return jsonDecode(response.data);
  // }
}