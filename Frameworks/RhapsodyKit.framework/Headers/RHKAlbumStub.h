//
//  RHKAlbumStub.h
//  RhapsodyKit
//
//  Copyright (c) 2014 Rhapsody International Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface RHKAlbumStub : NSObject

@property (nonatomic, copy, readonly) NSString *ID;

@property (nonatomic, copy, readonly) NSString *name;

-(instancetype)initWithID:(NSString*)ID
                     name:(NSString*)name;

@end
