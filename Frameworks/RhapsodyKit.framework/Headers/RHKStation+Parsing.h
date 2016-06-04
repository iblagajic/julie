//
//  RHKStation+Parsing.h
//  RhapsodyKit
//
//  Copyright (c) 2014 Rhapsody International Inc. All rights reserved.
//


#import <RhapsodyKit/RhapsodyKit.h>
#import "RHKStation.h"

@interface RHKStation (Parsing)

+(instancetype)parseFromJson:(id)json;

+(NSArray*)parseStationsFromJson:(NSArray*)jsonArray;

-(BOOL)validate:(NSError**)error;

@end
