//
//  RHKUser.h
//  RhapsodyKit
//
//  Copyright (c) 2014 Rhapsody International Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

/**
 Notification will be posted when user model changes.
 */
extern NSString* const RHKNotificationUserChanged;

/**
 Subscription state.
 */
typedef NS_ENUM(NSInteger, RHKSubscriptionState) {
    RHKSubscriptionStateUnknown  = 0, /* unknown subscription state, maybe user needs to update their SDK version    */
    RHKSubscriptionStateTrial    = 1, /* user is in a free trial                                                     */
    RHKSubscriptionStatePaying   = 2, /* user is paying                                                              */
    RHKSubscriptionStateExpired  = 3, /* trial has ended, user has not yet subscribed                                */
};

/**
 User model.
 */
@interface RHKUser : NSObject

/**
 User ID for Rhapsody Service.
 */
@property (nonatomic, copy, readonly)   NSString                *ID;

/**
 Subscription state for user.
 */
@property (nonatomic, assign, readonly) RHKSubscriptionState     subscriptionState;

/**
 Expiration date for current subscription state.
 */
@property (nonatomic, copy, readonly)   NSDate                  *expirationDate;

/**
 Number of plays remaining if user is on a play based tier.
 If this parameter is `nil`, then user isn't on a play based tier.
 */
@property (nonatomic, copy, readonly)   NSNumber                *playsRemaining;

@end
