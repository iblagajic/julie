//
//  RHKRhapsody.h
//  RhapsodyKit
//
//  Copyright (c) 2014 Rhapsody International Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

@class RHKUser;
@class RHKStation;

@class RHKRequest;
@class RHKOAuthToken;

@class RHKTrackPlayer;

@class RHKSession;
@class RHKSessionCachingPolicy;

@class RHKStationPlayer;

typedef void (^StationPlayerCompletion)(RHKStationPlayer *stationPlayer, NSError *error);

typedef void (^OpenSessionCompletionHandler)(RHKSession *session, NSError *error);

typedef void (^RequestCompletionHandler)(id json, NSError *error);

/**
 HTTP method type
 */
typedef NS_ENUM(NSInteger, RHKHTTPMethod) {
    RHKHTTPMethodGET,
    RHKHTTPMethodPOST,
    RHKHTTPMethodPUT,
    RHKHTTPMethodDELETE,
};

/**
 RhapsodyKit engine.
 */
@interface RHKRhapsody : NSObject

#pragma mark - Factory methods

/**
 Creates RhapsodyKit engine. 
 
 @param consumerKey     Key that will be used to access APIs.
 @param consumerSecret  Secret information that will be used for authentication purposes.

 To obtain `consumerKey` and `consumerSecret`, please register at RhapsodyKit portal.
 https://developer.rhapsody.com/
 */
+(RHKRhapsody*)rhapsodyWithConsumerKey:(NSString*)consumerKey
                        consumerSecret:(NSString*)consumerSecret;

/**
 Creates RhapsodyKit engine.
 
 @param consumerKey             Key that will be used to access APIs.
 @param consumerSecret          Secret information that will be used for authentication purposes.
 @param sessionCachingPolicy    Policy that controls how session will be persisted during it's lifetime.
 
 To obtain `consumerKey` and `consumerSecret`, please register at RhapsodyKit portal.
 https://developer.rhapsody.com/
 */
+(RHKRhapsody*)rhapsodyWithConsumerKey:(NSString*)consumerKey
                        consumerSecret:(NSString*)consumerSecret
                  sessionCachingPolicy:(RHKSessionCachingPolicy*)sessionCachingPolicy;

/**
 Creates RhapsodyKit engine.
 
 @param consumerKey             Key that will be used to access APIs.
 @param consumerSecret          Secret information that will be used for authentication purposes.
 @param sessionCachingPolicy    Policy that controls how session will be persisted during it's lifetime.
 @param notificationCenter      Notification center that the SDK should use.
 
 To obtain `consumerKey` and `consumerSecret`, please register at RhapsodyKit portal.
 https://developer.rhapsody.com/
 */
+(RHKRhapsody*)rhapsodyWithConsumerKey:(NSString*)consumerKey
                        consumerSecret:(NSString*)consumerSecret
                  sessionCachingPolicy:(RHKSessionCachingPolicy*)sessionCachingPolicy
                    notificationCenter:(NSNotificationCenter*)notificationCenter;

#pragma mark - Configuration

/**
 Returns the currently set OAuth consumer key.
 */
@property (nonatomic, copy, readonly) NSString *consumerKey;

/**
 Returns the currently set OAuth consumer secret.
 */
@property (nonatomic, copy, readonly) NSString *consumerSecret;

#pragma mark - Session

/**
 Calculates url that handles RhapsodyKit login logic.
 
 @param Url where user will be redirected after login process. This is usually your 
        web service url that will extract OAuth token from response.
 */
+(NSString*)loginUrlWithConsumerKey:(NSString*)consumerKey
                        redirectUrl:(NSURL*)redirectUrl;

/**
 Returns current session that the engine is using.
 */
@property (nonatomic, readonly)         RHKSession   *session;

/**
 Returns information is session open and usable to make authenticated API calls.
 */
@property (nonatomic, assign, readonly) BOOL        isSessionOpen;

/**
 Opens session with code from implicit OAuth flow
 */
-(void)openSessionWithOAuthCode:(NSString*)code
                        baseURL:(NSURL*)baseURL
              completionHandler:(OpenSessionCompletionHandler)completionHandler;


/**
 Opens session for OAuth token.
 */
- (void)openSessionWithToken:(RHKOAuthToken*)token
           completionHandler:(OpenSessionCompletionHandler)completionHandler;

/**
 Refreshes existing open session
 
 @warning Only call this method when the session is opened.
 
 */
typedef void (^RefreshSessionCompletionHandler)(RHKSession *session, NSError *error);
- (void)refreshSessionWithCompletionHandler:(RefreshSessionCompletionHandler)handler;

/**
 Closes opened session.
 */
- (void)closeSession;

#pragma mark - API

/**
 Convenience method for communication with the Rhapsody APIs.
 
 @param method          HTTP method.
 @param path            HTTP request path.
 @param authenticated   Add authentication info to request.
 @param params          HTTP request parameters.
 @param completion      Callback that will be called if request isn't cancelled.
 
 @warning   Calling this method with true value for authenticated param will cause exception if
            session isn't opened.
 */
-(RHKRequest*)requestForMethod:(RHKHTTPMethod)method
                          path:(NSString*)path
                 authenticated:(BOOL)authenticated
                        params:(NSDictionary*)params
                    completion:(RequestCompletionHandler)completion;

#pragma mark - Playback
/**
 Creates radio player that enables playback of radio stations.
 */
-(RHKRequest*)createStationPlayerFor:(NSString*)identifier
                            complete:(StationPlayerCompletion)complete;

/**
 Returns player instance.
 */
@property (nonatomic, strong, readonly) RHKTrackPlayer        *player;

#pragma mark - Notifications

@property (nonatomic, strong, readonly) NSNotificationCenter  *notificationCenter;

/**
 Posted when the current track failed. Check userInfo's RHKNotificationErrorKey for the cause.
 */
extern NSString* const RHKNotificationCurrentTrackFailed;

/**
 Posted when the upcoming track failed. Check userInfo's RHKNotificationErrorKey for the cause.
 */
extern NSString* const RHKNotificationUpcomingTrackFailed;

/**
 Posted at the start of each network request.
 */
extern NSString* const RHKNotificationNetworkRequestBegan;

/**
 Posted at the end of each network request.
 */
extern NSString* const RHKNotificationNetworkRequestEnded;

/**
 Posted when session changes.
 */
extern NSString* const RHKNotificationSessionChanged;

/**
 Key of old session in user info for `RHKNotificationSessionChanged` notification
 */
extern NSString* const RHKNotificationSessionChangedFormerSessionKey;

#pragma mark - Notification user info keys

extern NSString* const RHKNotificationErrorKey;

#pragma mark - Errors

extern NSString* const RHKErrorDomain;

typedef NS_ENUM(NSInteger, RHKErrorCode) {
    RHKErrorUnknown = 0,
    
    RHKErrorCanceled,
    
    RHKErrorAuthenticationError,
    
    RHKErrorAuthorizationError,
    
    RHKErrorResourceNotFound,
    
    RHKErrorConnectionFailed,
    
    RHKErrorPlaybackSessionInvalid,

};

@end
