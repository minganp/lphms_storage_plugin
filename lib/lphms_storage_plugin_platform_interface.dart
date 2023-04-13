import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'lphms_storage_plugin_method_channel.dart';

abstract class LphmsStoragePluginPlatform extends PlatformInterface {
  /// Constructs a LphmsStoragePluginPlatform.
  LphmsStoragePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static LphmsStoragePluginPlatform _instance = MethodChannelLphmsStoragePlugin();

  /// The default instance of [LphmsStoragePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelLphmsStoragePlugin].
  static LphmsStoragePluginPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [LphmsStoragePluginPlatform] when
  /// they register themselves.
  static set instance(LphmsStoragePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
