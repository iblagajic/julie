//
//  Player.swift
//  Julie
//
//  Created by Ivan Blagajić on 04/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import RxSwift

class Player {
    
    let rhapsody: RHKRhapsody
    
    var tracks = [RHKTrack]()
    
    let bag = DisposeBag()
    
    init(rhapsody: RHKRhapsody) {
        self.rhapsody = rhapsody
        rhapsody.notificationCenter.rx_notification(RHKNotificationPlaybackStateChanged)
            .map { _ in () }
            .subscribeNext(playerStateChanged)
            .addDisposableTo(bag)
    }
    
    func startPlaying() {
        rhapsody.fetchFavorites()
            .map { tracks in
                guard tracks.count > 0 else {
                    return ""
                }
                let range = UInt32(tracks.count)
                let rand = Int(arc4random_uniform(range))
                return tracks[rand].album.ID
        }.flatMap(rhapsody.fetchTracks)
        .asDriver(onErrorJustReturn: [])
        .driveNext { [weak self] tracks in
            self?.tracks = tracks
            self?.rhapsody.player.playTrack(tracks.first)
        }.addDisposableTo(bag)
    }
    
    private func playerStateChanged() {
        switch rhapsody.player.playbackState {
        case RHKPlaybackStateFinished:
            skipNext()
        default:
            break
        }
    }
    
    func skipNext() {
        let currentTrack = rhapsody.player.currentTrack
        guard let currentTrackIndex = tracks.indexOf(currentTrack) where tracks.count > currentTrackIndex + 1 else {
            return
        }
        let nextTrack = tracks[currentTrackIndex + 1]
        rhapsody.player.playTrack(nextTrack)
    }
    
}
