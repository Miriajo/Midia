//
//  GoogleBooksAPIConsumerURLSession.swift
//  Midia
//
//  Created by Casa on 4/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation

class GoogleBooksAPIConsumerURLSession: MediaItemAPIConsumable {
   
    
    let session = URLSession.shared
    
// Extraído a fichero Constants
//    let apiKey = "" -- credencial google
//    
//    func getAbsoluteURL(withQueryParams queryParams: [String]) -> URL {
//      
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "www.googleapis.com"
//        components.path = "/books/v1/volumes"
//        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
//        components.queryItems?.append(URLQueryItem(name: "q", value: queryParams.joined(separator: "+")))
//        
//        return components.url!
//    }
    
    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        
        let url = GoogleBooksAPIConstants.getAbsoluteURL(withQueryParams: ["2019"])
        let task = session.dataTask(with: url) { (data, response, error) in
            // si hay error lo paso para arriba con la closure de failure
            if let error = error {
                DispatchQueue.main.async { failure(error) }
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let bookCollection = try decoder.decode(BookCollection.self, from: data)
                    DispatchQueue.main.async { success(bookCollection.items ?? []) } // ?? [] significa que si lo anterior es nil envia una lista vacía
                } catch {
                    DispatchQueue.main.async { failure(error) } // Error parseando, lo enviamos para arriba y que se ocupe el Provider
                }
            } else {
                DispatchQueue.main.async { success([]) }
            }
        }
        
        task.resume()
    }
    
    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        // TODO: completar en casa
    }
    
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        // TODO: completar
    }
    
}
