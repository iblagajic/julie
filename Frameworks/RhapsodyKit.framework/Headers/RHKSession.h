//
//  RHKSession.h
//  RhapsodyKit
//
//  Copyright (c) 2014 Rhapsody International Inc. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "RHKOAuthToken.h"
#import "RHKUser.h"

/**
 Session state.
 */
typedef NS_ENUM(NSInteger, RHKSessionState) {
    RHKSessionStateClosed  = 0,  /* Session is invalid. */
    RHKSessionStateOpen    = 1,  /* Session is in opened state and can be used to make authenticated API calls. */
    RHKSessionStateExpired = 2,  /* Session was opened, but has expired. */
};

/**
 Authentication session.
 */
@interface RHKSession : NSObject

/**
 Session state.
 */
@property (nonatomic, assign, readonly) RHKSessionState  state;

/**
 Session OAuth token.
 */
@property (nonatomic, strong, readonly) RHKOAuthToken    *token;

/**
 User model for current authenticated.
 */
@property (nonatomic, strong, readonly) RHKUser          *user;

/**
 Convenience property that returns can session be used to make authenticated HTTP requests.
 */
@property (nonatomic, assign, readonly) BOOL            isOpen;

@end
