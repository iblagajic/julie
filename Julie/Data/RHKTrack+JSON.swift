//
//  RHKTrack+JSON.swift
//  Julie
//
//  Created by Ivan Blagajić on 05/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

extension RHKTrack {
    
    static func fromJson(trackJson: AnyObject) -> RHKTrack {
        return RHKTrack.parseFromJson(trackJson)
    }
    
    static func tracksFromJson(tracksJson: [AnyObject]) -> [RHKTrack] {
        return tracksJson.map(fromJson)
    }
}
