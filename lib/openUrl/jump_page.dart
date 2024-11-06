import 'package:url_launcher/url_launcher.dart';

class jump_page {
  static Future<bool> jump(String url) async {
    return await launchUrl(
      Uri.parse(url),
    );
  }
}
