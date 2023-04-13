import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lphms_storage_plugin/lphms_storage_plugin_method_channel.dart';

void main() {
  MethodChannelLphmsStoragePlugin platform = MethodChannelLphmsStoragePlugin();
  const MethodChannel channel = MethodChannel('lphms_storage_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
