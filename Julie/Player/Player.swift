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
    
    let bag = DisposeBag()
    
    init(rhapsody: RHKRhapsody) {
        self.rhapsody = rhapsody
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
            // TODO: Play album
            let firstTrack = tracks.first
            self?.rhapsody.player.playTrack(firstTrack)
        }.addDisposableTo(bag)
    }
    
}
