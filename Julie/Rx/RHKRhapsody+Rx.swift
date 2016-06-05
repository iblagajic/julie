//
//  RHKRhapsody+Rx.swift
//  Julie
//
//  Created by Ivan Blagajić on 05/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import RxSwift

extension RHKRhapsody {
    
    func rx_favorites() -> Observable<AnyObject> {
        return Observable.create { observer -> Disposable in
            self.requestForMethod(.GET,
                path: "me/favorites",
                authenticated: true,
                params: ["limit" : 100]) { (response, err) in
                    if let favoritesResponse = response {
                        observer.onNext(favoritesResponse)
                        observer.onCompleted()
                    } else {
                        observer.onError(err)
                    }
            }
            return NopDisposable.instance
        }
    }
    
    func rx_tracks(inAlbum albumId: String) -> Observable<AnyObject> {
        return Observable.create { observer -> Disposable in
            self.requestForMethod(.GET,
                path: "albums/\(albumId)/tracks",
                authenticated: false,
                params: nil) { (response, err) in
                    if let tracksResponse = response {
                        observer.onNext(tracksResponse)
                        observer.onCompleted()
                    } else {
                        observer.onError(err)
                    }
                }
            return NopDisposable.instance
        }
    }
    
    func rx_nowPlaying() -> Observable<RHKTrack?> {
        return player.rx_observe(RHKTrack.self, "currentTrack")
    }
    
}
