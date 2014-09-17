//
//  KBKeyRing.h
//  KBCrypto
//
//  Created by Gabriel on 7/31/14.
//  Copyright (c) 2014 Gabriel Handford. All rights reserved.
//

#import "KBKey.h"

#import <JavaScriptCore/JavaScriptCore.h>

typedef void (^KBKeyRingProcessCompletionBlock)(NSArray *bundles);
typedef void (^KBKeyRingProcessBlock)(NSArray */*of id<KBKey>*/keys, KBKeyRingProcessCompletionBlock completion);

@protocol KBKeyRing <NSObject>

/*!
 Lookup keys.
 @param PGPKeyIds PGP key ids
 @param capabilities Capabilities bitmask
 @param success Key bundles
 @param failure Failure
 */
- (void)lookupPGPKeyIds:(NSArray *)PGPKeyIds capabilities:(KBKeyCapabilities)capabilities success:(void (^)(NSArray *keyBundles))success failure:(void (^)(NSError *error))failure;

/*!
 Verify signers.
 @param signers List of key fingerprints to verify
 @param success Array of [KBSigner]
 */
- (void)verifyKeyFingerprints:(NSArray *)keyFingerprints success:(void (^)(NSArray *signers))success failure:(void (^)(NSError *error))failure;

@end


@protocol KBKeyRingExport <JSExport>
JSExportAs(fetch,
- (void)fetch:(NSArray *)keyIds ops:(NSUInteger)ops success:(JSValue *)success failure:(JSValue *)failure
);
@end


/*!
 Default key ring implementation.
 */
@interface KBKeyRing : NSObject <KBKeyRing, KBKeyRingExport>

@property (copy) KBKeyRingProcessBlock process;

/*!
 Add bundle to key ring.
 */
- (void)addKey:(id<KBKey>)key PGPKeyIds:(NSArray *)PGPKeyIds capabilities:(KBKeyCapabilities)capabilities;

@end
