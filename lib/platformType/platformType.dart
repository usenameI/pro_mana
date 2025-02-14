import 'dart:io';

enum RunType { android, ios, windows, mac, linux }

abstract final class PlatformType {
 static runOnPlatform({required RunTypeConfig runTypeConfig,required Function() excutionCall}) {
    if (Platform.isAndroid) {
      if (runTypeConfig.grants.contains(RunType.android)) {
        excutionCall();
      }
    } else if (Platform.isIOS) {
      if (runTypeConfig.grants.contains(RunType.ios)) {
        excutionCall();
      }
    } else if (Platform.isWindows) {
      if (runTypeConfig.grants.contains(RunType.windows)) {
        excutionCall();
      }
    } else if (Platform.isLinux) {
      if (runTypeConfig.grants.contains(RunType.linux)) {
        excutionCall();
      }
    } else if (Platform.isMacOS) {
      if (runTypeConfig.grants.contains(RunType.mac)) {
        excutionCall();
      }
    } 
  }
}

class RunTypeConfig {
  RunTypeConfig({
    required this.grants
  });
  List<RunType> grants = [];
}
