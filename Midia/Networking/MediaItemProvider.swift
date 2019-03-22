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
      // self.mediaItemKind = mediaItemKind
        switch mediaItemKind {
        case .book:
  //         self.init(withMediaItemKind: mediaItemKind, apiConsumer: GoogleBooksAPIConsumerURLSession())
           self.init(withMediaItemKind: mediaItemKind, apiConsumer: GoogleBooksAPIConsumerAlamofire())
//        case .game:
//            self.init(withMediaItemKind: mediaItemKind, apiConsumer: MockMediaItemAPIConsumer())
        case .movie:
            //self.init(withMediaItemKind: mediaItemKind, apiConsumer: ITunesMoviesAPIConsumerNSURLSession())
            self.init(withMediaItemKind: mediaItemKind, apiConsumer: ITunesMoviesAPIConsumerAlamofire())
        case .game:
             //            self.init(withMediaItemKind: mediaItemKind, apiConsumer: iTunesMoviesAPIConsumer)
            fatalError("MediaItemKind not supported yet :( coming soon") // esto es de la práctica
        
        }
    }

    // VERSIÓN 1 - DEVOLUCIÓN LISTA
//    func getHomeMediaItems() -> [MediaItemProvidable] {
//        // guardar cosas en caché
//        // comprobar que estamos en el hilo principal
//        return apiConsumer.getLatestMediaItems()  // esta es la función de MockMedia
//    }
    
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


// ESTO SE VA A TESTS
//class MockMediaItemAPIConsumer: MediaItemAPIConsumable {
//
//    // VERSION 1
//    //    func getLatestMediaItems() -> [MediaItemProvidable] {
//    //        return [Game()]
//    //    }
//    //
//    
//    // VERSION 2
//    // @escaping significa que yo puedo haber terminado mi función pero lo asíncrono podría seguir en funcionamiento, entonces indica que puede terminar cuando acabe.
//    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void)  {
//        let queue = DispatchQueue.global()
//        queue.async {
//            // llama a la API de terceros
//   //         print(Thread.current.description)
//            Thread.sleep(forTimeInterval: 5)
//            let mainQueue = DispatchQueue.main
//            mainQueue.async {  // Volvemos a la mainQueue porque sino no podemos modificar la interfaz gráfica
//                 success([Book(bookId: "1", title: "One book"), Book(bookId: "2", title: "Second Book")])
//            }
//        }
//    }
//
//}
