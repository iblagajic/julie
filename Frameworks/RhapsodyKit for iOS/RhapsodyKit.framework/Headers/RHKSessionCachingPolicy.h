//
//  RHKSessionCachingPolicy.h
//  RhapsodyKit
//
//  Copyright (c) 2014 Rhapsody International Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

/**
 Default key under which session is cached in `NSUserDefaults`.
 */
extern NSString *RHKSessionCachingPolicyUserDefaultsKey;

/**
 Handlers persistance of session.
 */
@interface RHKSessionCachingPolicy : NSObject

/**
 Called by the framework when persistance of session data is needed.
 */
-(void)cacheSerializedSession:(NSData*)encryptedSessionData;

/**
 Called by the framework when serialized session data is needed.
 */
-(NSData*)fetchSerializedSession;

/**
 Implementation that doesn't cache session data.
 When RHKSession is deallocated from memory, user needs to manually open a new session.
 */
+(RHKSessionCachingPolicy*)notCachingPolicy;

/**
 Implementation that caches session data in `NSUserDefaults` under key `RHKSessionCachingPolicyUserDefaultsKey`.
 */
+(RHKSessionCachingPolicy*)defaultPolicy;

@end
