#import "AwsPollyPlugin.h"
#if __has_include(<aws_polly/aws_polly-Swift.h>)
#import <aws_polly/aws_polly-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "aws_polly-Swift.h"
#endif

@implementation AwsPollyPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAwsPollyPlugin registerWithRegistrar:registrar];
}
@end
