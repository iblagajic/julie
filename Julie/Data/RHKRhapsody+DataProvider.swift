//
//  RHKRhapsody+DataProvider.swift
//  Julie
//
//  Created by Ivan Blagajić on 05/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import RxSwift

extension RHKRhapsody {
    
    func fetchFavorites() -> Observable<[RHKTrack]> {
        return rx_favorites().map(RHKTrack.tracksFromJson)
    }
    
    func fetchTracks(inAlbum albumId: String) -> Observable<[RHKTrack]> {
        return rx_tracks(inAlbum: albumId).map(RHKTrack.tracksFromJson)
    }
    
    func currentAlbumImage() -> Observable<UIImage?> {
        let session = NSURLSession.sharedSession()
        return rx_nowPlaying()
            .flatMap { track -> Observable<UIImage?> in
                guard let albumId = track?.album.ID else {
                    return Observable.empty()
                }
                let urlString = "http://direct.rhapsody.com/imageserver/v2/albums/\(albumId)/images/300x300.jpg"
                let request = NSMutableURLRequest()
                request.URL = NSURL(string: urlString)
                return session.rx_data(request).map { data in
                    return UIImage(data: data)
                }
        }
    }
    
    func nowPlaying() -> Observable<RHKTrack?> {
        return rx_nowPlaying()
    }
    
}
