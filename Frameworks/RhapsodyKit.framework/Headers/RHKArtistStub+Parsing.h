//
//  RHKArtistStub+Parsing.h
//  RhapsodyKit
//
//  Copyright (c) 2014 Rhapsody International Inc. All rights reserved.
//


#import <RhapsodyKit/RhapsodyKit.h>
#import "RHKArtistStub.h"

@interface RHKArtistStub (Parsing)

+(instancetype)parseFromJson:(id)json;

-(BOOL)validate:(NSError**)error;

@end

