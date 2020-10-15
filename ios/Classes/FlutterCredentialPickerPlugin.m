#import "FlutterCredentialPickerPlugin.h"
#if __has_include(<flutter_credential_picker/flutter_credential_picker-Swift.h>)
#import <flutter_credential_picker/flutter_credential_picker-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_credential_picker-Swift.h"
#endif

@implementation FlutterCredentialPickerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterCredentialPickerPlugin registerWithRegistrar:registrar];
}
@end
