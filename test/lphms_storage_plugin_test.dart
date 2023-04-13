import 'package:flutter_test/flutter_test.dart';
import 'package:lphms_storage_plugin/lphms_storage_plugin.dart';
import 'package:lphms_storage_plugin/lphms_storage_plugin_platform_interface.dart';
import 'package:lphms_storage_plugin/lphms_storage_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockLphmsStoragePluginPlatform 
    with MockPlatformInterfaceMixin
    implements LphmsStoragePluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final LphmsStoragePluginPlatform initialPlatform = LphmsStoragePluginPlatform.instance;

  test('$MethodChannelLphmsStoragePlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelLphmsStoragePlugin>());
  });

  test('getPlatformVersion', () async {
    LphmsStoragePlugin lphmsStoragePlugin = LphmsStoragePlugin();
    MockLphmsStoragePluginPlatform fakePlatform = MockLphmsStoragePluginPlatform();
    LphmsStoragePluginPlatform.instance = fakePlatform;
  
    expect(await lphmsStoragePlugin.getPlatformVersion(), '42');
  });
}
