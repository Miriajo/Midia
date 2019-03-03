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
    
    let mediaItemKind: MediaItemKind   // tipo
    let apiConsumer: MediaItemAPIConsumable  // servicio (protocolo) - Tendrá un consumer de la API que seam GoogleBooks, Games, iTunesMovies
    
    private init(withMediaItemKind mediaItemKind: MediaItemKind, apiConsumer: MediaItemAPIConsumable) {
        self.mediaItemKind = mediaItemKind
        self.apiConsumer = apiConsumer
    }
    
    convenience init(withMediaItemKind mediaItemKind: MediaItemKind) { // aquí definimos cuál es el servicio de cada tipo
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

    func getHomeMediaItems() -> [MediaItemProvidable] {
        // guardar cosas en caché
        // comprobar que estamos en el hilo principal
        return apiConsumer.getLatestMediaItems()  // esta es la función de MockMedia
    }
}

class MockMediaItemAPIConsumer: MediaItemAPIConsumable {
    
    func getLatestMediaItems() -> [MediaItemProvidable] {
        return [Game()]
    }
    
}
