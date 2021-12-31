#import "PhonePlusPlugin.h"
#if __has_include(<phone_plus/phone_plus-Swift.h>)
#import <phone_plus/phone_plus-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "phone_plus-Swift.h"
#endif

@implementation PhonePlusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftPhonePlusPlugin registerWithRegistrar:registrar];
}
@end
