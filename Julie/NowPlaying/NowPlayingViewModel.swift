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
    let albumImageTap = PublishSubject<Void>()
    
    let albumImage: Observable<UIImage?>
    let nowPlayingTitle: Observable<String>
    let artistName: Observable<String>
    let trackName: Observable<String>
    let canPrevious: Observable<Bool>
    let canNext: Observable<Bool>
    let canPause: Observable<Bool>
    let progress: Observable<CGFloat>
    
    let bag = DisposeBag()
    
    init(player: Player, navigationService: NavigationService) {
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
        canPrevious = nowPlayingTrack.map { _ in player.hasPrevious }
        canNext = nowPlayingTrack.map { _ in player.hasNext }
        canPause = rhapsody.rx_state().map { return $0 == RHKPlaybackStatePlaying }
        progress = rhapsody.rx_progress().map { CGFloat($0) }
        nextTap.subscribeNext(player.next).addDisposableTo(bag)
        albumImageTap.subscribeNext {
            navigationService.pushDetails(player)
        }.addDisposableTo(bag)
        playPauseTap.withLatestFrom(canPause).subscribeNext { canPause in
            if canPause {
                player.pause()
            } else {
                player.resume()
            }
        }.addDisposableTo(bag)
    }
}
