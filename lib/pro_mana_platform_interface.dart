import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pro_mana_method_channel.dart';

abstract class ProManaPlatform extends PlatformInterface {
  /// Constructs a ProManaPlatform.
  ProManaPlatform() : super(token: _token);

  static final Object _token = Object();

  static ProManaPlatform _instance = MethodChannelProMana();

  /// The default instance of [ProManaPlatform] to use.
  ///
  /// Defaults to [MethodChannelProMana].
  static ProManaPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ProManaPlatform] when
  /// they register themselves.
  static set instance(ProManaPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
