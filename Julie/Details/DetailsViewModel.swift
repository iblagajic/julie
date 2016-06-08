//
//  DetailsViewModel.swift
//  Julie
//
//  Created by Ivan Blagajić on 06/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import RxSwift
import RxDataSources

struct Section {
    let items: [RHKTrack]
}

extension Section: SectionModelType {
    
    init(original: Section, items: [RHKTrack]) {
        self.items = items
    }
    
}

class DetailsViewModel {
    
    let selectTrack = PublishSubject<NSIndexPath>()
    
    let sections: Observable<[Section]>
    let nowPlayingIndex: Observable<Int?>
    let headerImage: Observable<UIImage?>
    
    private let bag = DisposeBag()
    
    init(player: Player) {
        let section = Section(items: player.tracks)
        sections = Observable.just([section])
        nowPlayingIndex = player.nowPlayingIndex()
        headerImage = player.rhapsody.currentAlbumImage()
        
        selectTrack.subscribeNext { ip in
            player.playTrack(ip.row)
        }.addDisposableTo(bag)
    }
    
}
