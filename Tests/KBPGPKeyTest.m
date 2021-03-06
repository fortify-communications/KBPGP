//
//  KBPGPKeyTest.m
//  KBPGP
//
//  Created by Gabriel on 9/8/14.
//  Copyright (c) 2014 Gabriel Handford. All rights reserved.
//

#import <GRUnit/GRUnit.h>

#import "KBPGPKey.h"
#import "KBPGP.h"

@interface KBPGPKeyTest : GRTestCase
@property KBPGP *crypto;
@end

@implementation KBPGPKeyTest

- (NSString *)loadFile:(NSString *)file {
  NSString *path = [[NSBundle mainBundle] pathForResource:[file stringByDeletingPathExtension] ofType:[file pathExtension]];
  NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
  NSAssert(contents, @"No contents at file: %@", file);
  return contents;
}

- (void)setUp {
  if (!_crypto) _crypto = [[KBPGP alloc] init];
}

- (void)testSerialize:(dispatch_block_t)completion {
  NSString *bundle = [self loadFile:@"user1_private.asc"];
  [_crypto PGPKeyForPrivateKeyBundle:bundle keyBundlePassword:@"toomanysecrets" password:@"toomanysecrets2" success:^(KBPGPKey *PGPKey) {

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:PGPKey];
    KBPGPKey *PGPKey2 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    GRAssertEqualObjects(PGPKey2.secretKey, PGPKey.secretKey);
    
    completion();
    
  } failure:GRErrorHandler];
}

@end
