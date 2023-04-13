
import 'lphms_storage_plugin_platform_interface.dart';

class LphmsStoragePlugin {
  Future<String?> getPlatformVersion() {
    return LphmsStoragePluginPlatform.instance.getPlatformVersion();
  }
}
