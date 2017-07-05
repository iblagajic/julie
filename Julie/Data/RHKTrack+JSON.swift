//
//  RHKTrack+JSON.swift
//  Julie
//
//  Created by Ivan Blagajić on 05/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

extension RHKTrack {
    
    static func fromJson(_ trackJson: AnyObject) -> RHKTrack {
        return RHKTrack.parseFromJson(trackJson)
    }
    
    static func tracksFromJson(_ response: AnyObject) -> [RHKTrack] {
        guard let tracksJson = response as? [AnyObject] else {
            return []
        }
        return tracksJson.map(fromJson)
    }
}
