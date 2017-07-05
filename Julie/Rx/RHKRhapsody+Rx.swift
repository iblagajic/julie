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
            self.request(for: .GET,
                path: "me/favorites",
                authenticated: true,
                params: ["limit" : 100]) { (response, err) in
                    if let favoritesResponse = response {
                        observer.onNext(favoritesResponse as AnyObject)
                        observer.onCompleted()
                    } else {
                        observer.onError(err!)
                    }
            }
            return Disposables.create()
        }
    }
    
    func rx_tracks(inAlbum albumId: String) -> Observable<AnyObject> {
        return Observable.create { observer -> Disposable in
            self.request(for: .GET,
                path: "albums/\(albumId)/tracks",
                authenticated: false,
                params: nil) { (response, err) in
                    if let tracksResponse = response {
                        observer.onNext(tracksResponse as AnyObject)
                        observer.onCompleted()
                    } else {
                        observer.onError(err!)
                    }
                }
            return Disposables.create()
        }
    }
    
    func rx_nowPlaying() -> Observable<RHKTrack?> {
        return player.rx.observe(RHKTrack.self, "currentTrack")
    }
    
    func rx_state() -> Observable<RHKPlaybackState> {
        return player.rx.observe(RHKPlaybackState.self, "playbackState").filterNil()
    }
    
    func rx_progress() -> Observable<Float> {
        return notificationCenter
            .rx.notification(Notification.Name(rawValue: RHKNotificationPlayheadPositionChanged))
            .map { [unowned self] _ in
                Float(self.player.playheadPosition/self.player.currentTrackDuration)
            }
    }
    
    func rx_error() -> Observable<String> {
        return notificationCenter.rx.notification(Notification.Name(rawValue: RHKNotificationCurrentTrackFailed))
            .map { notification -> String in
                return notification.userInfo?[RHKNotificationErrorKey] as? String ?? ""
            }
    }
    
}
