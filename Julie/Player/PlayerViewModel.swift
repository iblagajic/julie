//
//  PlayerViewModel.swift
//  Julie
//
//  Created by Ivan Blagajić on 05/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import RxSwift

class PlayerViewModel {
    
    let playTap = PublishSubject<Void>()
    
    private let bag = DisposeBag()
    
    init(rhapsody: RHKRhapsody, dataProvider: DataProvider) {
        let player = Player(rhapsody: rhapsody, dataProvider: dataProvider)
        playTap.subscribeNext(player.startPlaying).addDisposableTo(bag)
    }
    
}
