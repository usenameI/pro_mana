

import 'package:path_provider/path_provider.dart';

class ObtainPath {
 ///获取手机存储路径
static Future<String> getPath()async{
    final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

}