//
//  RHKTrack.h
//  RhapsodyKit
//
//  Copyright (c) 2014 Rhapsody International Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

@class RHKAlbumStub;
@class RHKArtistStub;

@interface RHKTrack : NSObject<NSCopying>

@property (nonatomic, copy, readonly) NSString      *ID;

@property (nonatomic, copy, readonly) NSString      *name;

@property (nonatomic, copy, readonly) NSURL         *sampleURL;

@property (nonatomic, copy, readonly) NSNumber      *duration;

@property (nonatomic, copy, readonly) RHKArtistStub  *artist;

@property (nonatomic, copy, readonly) RHKAlbumStub   *album;

-(instancetype)initWithID:(NSString*)ID
                     name:(NSString*)name
                sampleURL:(NSURL*)sampleURL
                 duration:(NSNumber*)duration
                   artist:(RHKArtistStub*)artist
                    album:(RHKAlbumStub*)album;

@end
