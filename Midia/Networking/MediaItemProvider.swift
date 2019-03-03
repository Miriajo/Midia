//
//  MediaItemProvider.swift
//  Midia
//
//  Created by Casa on 3/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation

// A esta clase le pediremos MediaItems pero no sabemos quién nos lo va a dar

class MediaItemProvider {
    
    let mediaItemKind: MediaItemKind
    let apiConsumer: MediaItemAPIConsumable
    
    init(withMediaItemKind mediaItemKind: MediaItemKind, apiConsumer: MediaItemAPIConsumable) {
        self.mediaItemKind = mediaItemKind
        self.apiConsumer = apiConsumer
    }
    
    convenience init(withMediaItemKind mediaItemKind: MediaItemKind) {
      // self.mediaItemKind = mediaItemKind
        switch mediaItemKind {
        case .book:
//            self.init(withMediaItemKind: mediaItemKind, apiConsumer: GoogleBooksAPIConsumer)
            self.init(withMediaItemKind: mediaItemKind, apiConsumer: MockMediaItemAPIConsumer())
        case .game:
            self.init(withMediaItemKind: mediaItemKind, apiConsumer: MockMediaItemAPIConsumer())
        case .movie:
             //            self.init(withMediaItemKind: mediaItemKind, apiConsumer: iTunesMoviesAPIConsumer)
            fatalError("MediaItemKind not supported yet :( coming soon") // esto es de la práctica
        
        }
    }

    func getLatestMediaItems() -> [MediaItemProvidable] {
        return apiConsumer.getLatestMediaItems()
    }
}

class MockMediaItemAPIConsumer: MediaItemAPIConsumable {
    
    func getLatestMediaItems() -> [MediaItemProvidable] {
        return [Game()]
    }
    
}
