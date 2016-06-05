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
    
    init(rhapsody: RHKRhapsody, navigationService: NavigationService) {
        let player = Player(rhapsody: rhapsody)
        playTap.flatMap { () -> Observable<Void> in
            player.startPlaying()
            return rhapsody.rx_nowPlaying()
                .filter { $0 != nil }
                .take(1)
                .map { _ in () }
        }.subscribeNext {
            navigationService.pushNowPlaying(rhapsody)
        }.addDisposableTo(bag)
    }
    
}
