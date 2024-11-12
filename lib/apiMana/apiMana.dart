import 'dart:convert';

import 'package:dio/dio.dart';

///设置全局api使用的参数
class apiConfig {
  ///token
  static String token = '';

  ///接口使用的地址
  static String internetAddress = '';

  ///图片显示使用的地址
  static String imageInter = '';
}

class QueryConfig{
  var resetUrl;
  bool? setToken;
  QueryConfig({
    required this.resetUrl,
     this.setToken=true
  });
}

///网络请求封装
class apiMana {
  ///二次封装get请求
  static Future get(
      {required String path, Map<String, dynamic>? queryParameters,QueryConfig? queryConfig}) async {
    final dio = Dio();
    final res = await dio.get((){ 
          if(queryConfig!=null){
            if(queryConfig.resetUrl!=null){
              return queryConfig.resetUrl;
            }
          }
          return apiConfig.internetAddress+path;
        }(),
        queryParameters: queryParameters, 
        options: (){
          if(queryConfig!=null){
            if(queryConfig.setToken==true){
              return null;
            }
            
          }
          return Options(headers: {'Authorization': apiConfig.token});
        }());
            print('log__apiMana_post_返回数据:${res.data}');
    if (res.data is String) {
      return jsonDecode(res.data);
    }
    return res.data;
  }

  ///二次封装post请求
  static Future post({required String path, Map? data,QueryConfig? queryConfig}) async {
    final dio = Dio();
    final res = await dio.post(
      (){ 
          if(queryConfig!=null){
            if(queryConfig.resetUrl!=null){
              return queryConfig.resetUrl;
            }
          }
          return apiConfig.internetAddress+path;
        }(),
        data: data,
        options: (){
          if(queryConfig!=null){
            if(queryConfig.setToken==true){
              return null;
            }
            return Options(headers: {'Authorization': apiConfig.token});
          }
        }());
    print('log__apiMana_post_返回数据:${res.data}');
    if (res.data is String) {
      return jsonDecode(res.data);
    }
    return res.data;
  }

  ///二次封装delete请求
  static Future delete({required String path,QueryConfig? queryConfig}) async {
    final dio = Dio();
    final res = await dio.delete('${apiConfig.internetAddress}$path',
        options: Options(headers: {'Authorization': apiConfig.token}));
    if (res.data is String) {
      return jsonDecode(res.data);
    }
    return res.data;
  }

  ///二次封装文件上传
  static Future uploadFile(
      {required fileBytes, required fileName, required path,QueryConfig? queryConfig}) async {
    FormData formData = FormData.fromMap({
      'file': MultipartFile.fromBytes(fileBytes!, filename: fileName),
    });
    final dio = Dio();
    Response response = await dio.post(
      path, // 替换为您的服务器 URL
      data: formData,
    );
    if (response.data is String) {
      return jsonDecode(response.data);
    }
    return response.data;
  }
}
