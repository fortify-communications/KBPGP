#import <GHUnit/GHUnit.h>

@interface KBJSCoreTest : GHTestCase
@end

#import "KBCrypto.h"
#import "KBJSCore.h"

#import <GHKit/GHKit.h>


@interface KBCrypto ()
@property (readonly) KBJSCore *JSCore;
@end


@implementation KBJSCoreTest

- (void)testJSRandom {
  KBCrypto *crypto = [[KBCrypto alloc] init];
  JSContext *context = crypto.JSCore.context;
  
  [context evaluateScript:@"var randomHex = jscore.getRandomHexString(32);"];
  NSString *randomHex = [context[@"randomHex"] toString];
  GHAssertEquals([randomHex length], (NSUInteger)64, nil);
}

@end