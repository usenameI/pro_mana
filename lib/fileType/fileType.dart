
import 'package:path/path.dart' as path;
enum fileTypes{
  image,
  video,
  pdf,
  txt,
  other
}
///判断文件类型
class fileType{
  static fileTypes isVideoOrImage(String filePath) {
  // 获取文件后缀
  String extension = path.extension(filePath).toLowerCase();
  // 定义视频和图片的后缀
  const videoExtensions = ['.mp4', '.mkv', '.avi', '.mov', '.wmv'];
  const imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
  // 判断后缀
  if (videoExtensions.contains(extension)) {
    return fileTypes.video; // 是视频
  } else if (imageExtensions.contains(extension)) {
    return fileTypes.image; // 是图片
  } else {
    return fileTypes.other;
  }
}
}

