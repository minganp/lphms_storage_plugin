#import "LphmsStoragePlugin.h"
#if __has_include(<lphms_storage_plugin/lphms_storage_plugin-Swift.h>)
#import <lphms_storage_plugin/lphms_storage_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "lphms_storage_plugin-Swift.h"
#endif

@implementation LphmsStoragePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLphmsStoragePlugin registerWithRegistrar:registrar];
}
@end
