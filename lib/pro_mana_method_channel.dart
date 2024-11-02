import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pro_mana_platform_interface.dart';

/// An implementation of [ProManaPlatform] that uses method channels.
class MethodChannelProMana extends ProManaPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pro_mana');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
