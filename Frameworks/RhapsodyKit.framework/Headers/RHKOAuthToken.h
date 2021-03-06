//
//  RHKOAuthToken.h
//  RhapsodyKit
//
//  Copyright (c) 2014 Rhapsody International Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

/**
 OAuth token.
 */
@interface RHKOAuthToken : NSObject <NSCoding, NSCopying>

/**
 Value of access token.
 */
@property (nonatomic, copy, readonly) NSString    *accessToken;

/**
 Value of refresh token.
 */
@property (nonatomic, copy, readonly) NSString    *refreshToken;

/**
 Access token expiration date.
 */
@property (nonatomic, copy, readonly) NSDate      *expirationDate;

+(RHKOAuthToken*)authTokenWithAccessToken:(NSString*)accessToken
                             refreshToken:(NSString*)refreshToken
                           expirationDate:(NSDate*)date;

/**
 Convenience method easily check does token expire before `date`.
 */
-(BOOL)expiresBefore:(NSDate*)date;

@end
