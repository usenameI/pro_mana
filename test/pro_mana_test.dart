import 'package:flutter_test/flutter_test.dart';
import 'package:pro_mana/pro_mana.dart';
import 'package:pro_mana/pro_mana_platform_interface.dart';
import 'package:pro_mana/pro_mana_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockProManaPlatform
    with MockPlatformInterfaceMixin
    implements ProManaPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final ProManaPlatform initialPlatform = ProManaPlatform.instance;

  test('$MethodChannelProMana is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelProMana>());
  });

  test('getPlatformVersion', () async {
    ProMana proManaPlugin = ProMana();
    MockProManaPlatform fakePlatform = MockProManaPlatform();
    ProManaPlatform.instance = fakePlatform;

    expect(await proManaPlugin.getPlatformVersion(), '42');
  });
}
