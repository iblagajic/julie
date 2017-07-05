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
    var lastTrackPlayedIndex: Int?
    
    var hasPrevious: Bool {
        guard let track = rhapsody.player.currentTrack,
            let index = self.tracks.indexOf(track) else {
                return false
        }
        return index > 0
    }
    
    var hasNext: Bool {
        guard let track = rhapsody.player.currentTrack,
            let index = self.tracks.indexOf(track) else {
                return false
        }
        return self.tracks.count > index + 1
    }
    
    let bag = DisposeBag()
    
    init(rhapsody: RHKRhapsody) {
        self.rhapsody = rhapsody
        rhapsody.rx_state()
            .subscribeNext { [unowned self] state in
                switch state {
                case RHKPlaybackStateFinished:
                    self.next()
                default:
                    break
                }
            }.addDisposableTo(bag)
    }
    
    func startPlaying() -> Observable<Void> {
        return rhapsody.fetchFavorites()
            .map { tracks in
                guard tracks.count > 0 else {
                    return ""
                }
                let range = UInt32(tracks.count)
                let rand = Int(arc4random_uniform(range))
                return tracks[rand].album.ID
            }.flatMap(rhapsody.fetchTracks)
            .map { [unowned self] tracks in
                self.tracks = tracks
                self.playTrack(0)
            }
    }
    
    func previous() {
        if let lastTrackPlayedIndex = lastTrackPlayedIndex {
            playTrack(lastTrackPlayedIndex - 1)
        }
    }
    
    func next() {
        if let lastTrackPlayedIndex = lastTrackPlayedIndex {
            playTrack(lastTrackPlayedIndex + 1)
        }
    }
    
    func nowPlayingIndex() -> Observable<Int?> {
        return rhapsody.nowPlaying().map { [weak self] track in
            guard let track = track else {
                return nil
            }
            return self?.tracks.indexOf(track)
        }
    }
    
    func playTrack(_ atIndex: Int) {
        if let track = tracks[safe: atIndex] {
            lastTrackPlayedIndex = atIndex
            rhapsody.player.playTrack(track)
        }
    }
    
    func pause() {
        rhapsody.player.pausePlayback()
    }
    
    func resume() {
        rhapsody.player.resumePlayback()
    }
    
}
