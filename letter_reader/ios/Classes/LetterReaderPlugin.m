#import "LetterReaderPlugin.h"
#if __has_include(<letter_reader/letter_reader-Swift.h>)
#import <letter_reader/letter_reader-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "letter_reader-Swift.h"
#endif

@implementation LetterReaderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftLetterReaderPlugin registerWithRegistrar:registrar];
}
@end
