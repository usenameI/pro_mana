
import 'package:permission_handler/permission_handler.dart';

class premisstion{
 static Future<void> requestPermissions() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    print('log__有权限');
    await Permission.storage.request();
  }else{
print('log__无权限');
  }
}
}