//
//  RHKTrackPlayer.h
//  RhapsodyKit
//
//  Copyright (c) 2014 Rhapsody International Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

@class RHKTrack;

/**
 Enables single track playback.
 */
@interface RHKTrackPlayer : NSObject

#pragma mark Manually managed queue

/**
 * Plays a given track. If an access token has been given, the full-length track will be played.
 * If not, a 30-second sample will be used. Note that your app must be approved for full-length track playback.
 * Errors are handled through observing RHKNotificationCurrentTrackFailed.
 *
 *  @param track                     - Track to play immediately
 *  @param containerID               - Container ID that the track was played from (e.g. album ID, playlist ID ...).
                                        If the value is nil, then album ID will be used for this value.
                                        This value is being used to correctly display track in user history.
 *  @param eagerlyCacheTracks        - List of `RHKTrack` that will be precached after the current track is finished
                                        downloading
 *  @param playbackContext           - Custom object that could be later retrieved using `playbackContext` property.
 */

- (void)            playTrack:(RHKTrack*)track;

- (void)            playTrack:(RHKTrack*)track
                  containerID:(NSString*)containerID;

- (void)            playTrack:(RHKTrack*)track
                  containerID:(NSString*)containerID
           eagerlyCacheTracks:(NSArray*)eagerlyCacheTracks;

- (void)            playTrack:(RHKTrack*)track
                  containerID:(NSString*)containerID
           eagerlyCacheTracks:(NSArray*)eagerlyCacheTracks
              playbackContext:(id<NSObject>)playbackContext;

#pragma mark -

@property (nonatomic, readonly) RHKTrack *currentTrack;

/**
 * Observe RHKNotificationPlaybackContextChanged to be notified when this value changes.
 *
 *  @return Current playbackContext.
 */
- (id<NSObject>)playbackContext;

/**
 * Pauses playback.
 */
- (void)pausePlayback;

/**
 * Resumes playback.
 */
- (void)resumePlayback;

/**
 * Stops playback, clears the current track and cancels caching of upcoming tracks.
 */
- (void)stopPlayback;

/**
 * The current track's duration calculated from the loaded audio data. 
 * Observe RHKNotificationCurrentTrackDurationChanged to be notified when this value changes.
 */
@property (nonatomic, readonly) NSTimeInterval currentTrackDuration;

/**
 * The amount of the current track that has been downloaded, from 0 to 1. 
 * Observe RHKNotificationCurrentTrackAmountDownloadedChanged to be notified when this value changes.
 */
@property (nonatomic, readonly) float currentTrackAmountDownloaded;

/**
 * The playhead location in the current track. Its value is updated each second. 
 * Observe RHKNotificationPlayheadPositionChanged to be notified when this value changes.
 */
@property (nonatomic, readonly) NSTimeInterval playheadPosition;

/**
 * The maximum position available to seek to in the current track. 
 * This value depends on how much of the track has been loaded.
 */
@property (nonatomic, readonly) NSTimeInterval maxSeekPosition;

/**
 * Changes the playhead position for the current track.
 *
 * If given a position beyond the maxSeekPosition, the playhead position will be set to maxSeekPosition.
 *
 *  @return The resulting playhead position.
 */
- (NSTimeInterval)seekTo:(NSTimeInterval)position;

/**
 * Sets whether or not the user is scrubbing. For example, enable scrubbing when the user begins dragging, 
 * then call seekTo: while dragging and finally disable scrubbing when the user finishes dragging.
 */
- (void)setScrubbing:(BOOL)scrubbing;

/**
 * Audio level metering in decibels.
 */
- (void)leftChannelAverageDecibels:(float*)leftChannelAverageDecibels
           leftChannelPeakDecibels:(float*)leftChannelPeakDecibels
       rightChannelAverageDecibels:(float*)rightChannelAverageDecibels
          rightChannelPeakDecibels:(float*)rightChannelPeakDecibels;

typedef enum : NSInteger {
    RHKPlaybackStateStopped,
    RHKPlaybackStateBuffering,
    RHKPlaybackStatePlaying,
    RHKPlaybackStatePaused,
    RHKPlaybackStateFinished,
} RHKPlaybackState;

/**
 * The current playback state. Observe RHKNotificationPlaybackStateChanged to be notified when this value changes.
 */
@property (nonatomic, readonly) RHKPlaybackState playbackState;

#pragma mark - Notifications

extern NSString* const RHKNotificationPlaybackStateChanged;

extern NSString* const RHKNotificationPlaybackContextChanged;

extern NSString* const RHKNotificationCurrentTrackChanged;

extern NSString* const RHKNotificationCurrentTrackDurationChanged;

extern NSString* const RHKNotificationCurrentTrackAmountDownloadedChanged;

extern NSString* const RHKNotificationPlayheadPositionChanged;

@end
