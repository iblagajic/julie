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
    let dataProvider: DataProvider
    
    let bag = DisposeBag()
    
    init(rhapsody: RHKRhapsody, dataProvider: DataProvider) {
        self.rhapsody = rhapsody
        self.dataProvider = dataProvider
    }
    
    func startPlaying() {
        dataProvider.fetchFavorites()
            .asDriver(onErrorJustReturn: [])
            .driveNext { tracks in
                let range = UInt32(tracks.count)
                let rand = Int(arc4random_uniform(range))
                let track = tracks[rand]
                self.rhapsody.player.playTrack(track)
        }.addDisposableTo(bag)
    }
    
}
