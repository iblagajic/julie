//
//  DataProvider.swift
//  Julie
//
//  Created by Ivan Blagajić on 05/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import RxSwift

class DataProvider {
    
    let session = NSURLSession.sharedSession()
    let token: String
    
    init(token: String) {
        self.token = token
    }
    
    func fetchFavorites() -> Observable<[RHKTrack]> {
        let request = NSMutableURLRequest()
        request.URL = NSURL(string: "https://api.rhapsody.com/v1/me/favorites")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return session.rx_JSON(request).map { response in
            guard let tracks = response as? [AnyObject] else {
                return []
            }
            return RHKTrack.tracksFromJson(tracks)
        }
    }
    
}
