//
//  RHKPreviewTrack.h
//  RhapsodyKit
//
//  Created by Krunoslav Zaher on 12/8/14.
//  Copyright (c) 2014 Rhapsody International. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RHKTrack;
@class RHKArtistStub;

/**
 *  Next track in station playback queue.
 */
@interface RHKPreviewTrack : NSObject

/**
 *  Track description. This value can be `nil` depending on station type
 *  and user account.
 */
@property (nonatomic, strong, readonly) RHKTrack          *track;

/**
 *  Artist description. This property should always contain value.
 */
@property (nonatomic, strong, readonly) RHKArtistStub     *artist;

-(instancetype)initWithTrack:(RHKTrack*)track
                      artist:(RHKArtistStub*)artist;

@end
