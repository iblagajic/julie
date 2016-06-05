//
//  NowPlayingViewModel.swift
//  Julie
//
//  Created by Ivan Blagajić on 05/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import RxSwift

class NowPlayingViewModel {
    
    let previousTap = PublishSubject<Void>()
    let playPauseTap = PublishSubject<Void>()
    let nextTap = PublishSubject<Void>()
    
    let albumImage: Observable<UIImage?>
    let nowPlayingTitle: Observable<String>
    let artistName: Observable<String>
    let trackName: Observable<String>
    
    let bag = DisposeBag()
    
    init(player: Player) {
        let rhapsody = player.rhapsody
        albumImage = rhapsody.currentAlbumImage().shareReplay(1)
        let nowPlayingTrack = rhapsody.nowPlaying().shareReplay(1)
        nowPlayingTitle = nowPlayingTrack.map { track in
            guard let albumName = track?.album.name else {
                return ""
            }
            return "Now playing - \(albumName)"
        }
        artistName = nowPlayingTrack.map { $0?.artist.name ?? "" }
        trackName = nowPlayingTrack.map { $0?.name ?? "" }
        nextTap.subscribeNext(player.skipNext).addDisposableTo(bag)
    }
}
