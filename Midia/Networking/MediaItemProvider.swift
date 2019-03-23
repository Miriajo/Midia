//
//  MediaItemProvider.swift
//  Midia
//
//  Created by Miriam Sánchez on 3/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import Foundation

// A esta clase le pediremos MediaItems pero no sabemos quién nos lo va a dar

class MediaItemProvider {    

    var mediaItemKind: MediaItemKind   // tipo
    let apiConsumer: MediaItemAPIConsumable  // servicio (protocolo) - Tendrá un consumer de la API que seam GoogleBooks, Games, iTunesMovies
    
    
    init(withMediaItemKind mediaItemKind: MediaItemKind, apiConsumer: MediaItemAPIConsumable) {
        self.mediaItemKind = mediaItemKind
        self.apiConsumer = apiConsumer
    }
    
    convenience init(withMediaItemKind mediaItemKind: MediaItemKind) { // aquí definimos cuál es el servicio de cada tipo
        switch mediaItemKind {
        case .book:
  //         self.init(withMediaItemKind: mediaItemKind, apiConsumer: GoogleBooksAPIConsumerURLSession())
           self.init(withMediaItemKind: mediaItemKind, apiConsumer: GoogleBooksAPIConsumerAlamofire())
        case .movie:
            //self.init(withMediaItemKind: mediaItemKind, apiConsumer: ITunesMoviesAPIConsumerNSURLSession())
            self.init(withMediaItemKind: mediaItemKind, apiConsumer: ITunesMoviesAPIConsumerAlamofire())
        case .game:
             //            self.init(withMediaItemKind: mediaItemKind, apiConsumer: iTunesMoviesAPIConsumer)
            fatalError("MediaItemKind not supported yet :( coming soon") // esto es de la práctica
        
        }
    }
    
    // VERSIÓN 2 - DEVOLUCIÓN LISTA
    func getHomeMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        // guardar cosas en caché
       
        // En lugar de pedir YA la lista, será, dame una lista y si todo va bien y has conseguido la lista de MediaItems, yo la devuelvo.
        
        apiConsumer.getLatestMediaItems(onSuccess: { (mediaItems) in
            // comprobar que estamos en el hilo principal
            assert(Thread.current == Thread.main)
            success(mediaItems)
        }, failure: { (error) in
            assert(Thread.current == Thread.main)
            failure(error)
        })
    }
    
    func getSearchMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        
        //
        apiConsumer.getMediaItems(withQueryParams: queryParams, success: { (mediaItems) in
            assert(Thread.current == Thread.main)
            success(mediaItems)
        }) { (error) in
            assert(Thread.current == Thread.main)
            failure(error)
        }
        
        
    }
    
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        
        apiConsumer.getMediaItem(byId: mediaItemId, success: { (mediaItem) in
            // comprobar que estamos en el hilo principal
            assert(Thread.current == Thread.main)
            success(mediaItem)
        }) { (error) in
            assert(Thread.current == Thread.main)
            failure(error)
        }
        
    }
    
}
