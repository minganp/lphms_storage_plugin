import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'lphms_storage_plugin_platform_interface.dart';

/// An implementation of [LphmsStoragePluginPlatform] that uses method channels.
class MethodChannelLphmsStoragePlugin extends LphmsStoragePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('lphms_storage_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
