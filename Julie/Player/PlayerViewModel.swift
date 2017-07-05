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
    
    let loading: Observable<Bool>
    
    fileprivate let bag = DisposeBag()
    
    init(rhapsody: RHKRhapsody, navigationService: NavigationService) {
        let activityIndicator = ActivityIndicator()
        loading = activityIndicator.asObservable()
        let player = Player(rhapsody: rhapsody)
        playTap.flatMap { () -> Observable<Void> in
            return player.startPlaying()
                .trackActivity(activityIndicator)
            }.withLatestFrom(rhapsody.rx_nowPlaying())
            .mapVoid()
            .asDriver(onErrorJustReturn: ())
            .driveNext {
                navigationService.pushNowPlaying(player)
            }.addDisposableTo(bag)
    }
    
}
