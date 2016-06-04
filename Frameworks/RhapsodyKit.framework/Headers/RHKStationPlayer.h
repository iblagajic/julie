//
//  RHKStationPlayer.h
//  RhapsodyKit
//
//  Copyright (c) 2014 Rhapsody International Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

extern NSString * const RHKNotificationStationCurrentTrackChanged;
extern NSString * const RHKNotificationStationTracksChanged;
extern NSString * const RHKNotificationStationCurrentTrackPreferenceChanged;
extern NSString * const RHKNotificationStationSkipLimitChanged;

typedef double RHKPopularity;
typedef double RHKVariety;

typedef NS_ENUM(NSInteger, RHKStationTrackPreference) {
    RHKStationTrackDislike     = -1,
    RHKStationTrackIndifferent = 0,
    RHKStationTrackLike        = 1
};

@class RHKTrackPlayer;
@class RHKRhapsody;
@class RHKTrack;
@class RHKStation;

@class RHKPreviewTrack;

typedef void (^TuneStationCompletionHandler)(RHKStation *station, NSError *error);
typedef void (^SynchronizeCompletionHandler)(NSError *error);

@interface RHKStationPlayer : NSObject

/**
 *  Track player object used to play individual tracks.
 */
@property (nonatomic, strong, readonly) RHKTrackPlayer             *trackPlayer;

/**
 *  Current track that is being played. These properties are key value observable.
 */
@property (nonatomic, copy, readonly  ) RHKTrack                   *currentTrack;
@property (nonatomic, assign          ) RHKStationTrackPreference   currentTrackPreference;

/**
 *  Description of next tracks in playback queue. This property is key value observable.
 */
@property (nonatomic, copy, readonly  ) NSArray/*RHKPreviewTrack*/ *previewTracks;

/**
 *  If there is a limitation on the number of skips that can be performed, these 
 *  properties contain number of skips remaining for a specific station and
 *  when the first skip will expire.
 *  In case there is no limitation, these properties return `nil`.
 *
 *  These properties support key value observing. And key value observing will be
 *  triggered in case performing an action changes these properties. In case
 *  these properties change because of elapsed time period, key value observing
 *  mechanism will not be triggered.
 */
@property (nonatomic, copy, readonly  ) NSNumber                   *skipsRemaining;
@property (nonatomic, copy, readonly  ) NSDate                     *skipChangeTime;

// does it skip intermediate tracks?
// it skips tracks in between
-(void)playPreviewTrackAtIndex:(NSUInteger)trackIndex;

-(void)deletePreviewTrackAtIndex:(NSUInteger)trackIndex;

-(void)skipForward;

/**
 *  This method synchronizes `self` with server model.
 *
 *  This process includes:
 *      * sending like/dislike feedback
 *      * fetching preview tracks
 *      * refresh other station parameters
 *  
 *  This method will be automatically called at most once  on important events like:
 *      * performing `skipForward`
 *      * performing `playPreviewTrackAtIndex`
 *      * ...
 *
 *  Calling this method when there is nothing to synchronize won't cause unnecessary
 *  server API calls.
 */
-(void)synchronizeWithCompletion:(SynchronizeCompletionHandler)completion;

#pragma mark - Tuning

@property (nonatomic, readonly        ) BOOL                        isTunable;

@property (nonatomic, readonly        ) RHKPopularity               popularity;
@property (nonatomic, readonly        ) RHKVariety                  variety;

-(void)tuneStationPopularity:(RHKPopularity)popularity
                     variety:(RHKVariety)variety
                  completion:(TuneStationCompletionHandler)completion;

@end
