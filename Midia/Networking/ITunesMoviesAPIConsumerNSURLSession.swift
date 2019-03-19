//
//  ITunesMoviesAPIConsumerNSURLSession.swift
//  Midia
//
//  Created by Casa on 18/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation

class ITunesMoviesAPIConsumerNSURLSession: MediaItemAPIConsumable {
    
    let session = URLSession.shared
      
    
    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        
        
        let url = ITunesMoviesAPIConstants.getITunesAbsoluteURL(withQueryParams: ["top"])
        let task = session.dataTask(with: url) { (data, response, error) in
           
            if let error = error {
                DispatchQueue.main.async { failure(error) }
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                    DispatchQueue.main.async { success(movieCollection.results ?? []) }
                } catch {
                    DispatchQueue.main.async { failure(error) }
                }
            } else {
                DispatchQueue.main.async { success([]) }
            }
        }
        
        task.resume()
    }
    
    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        // TODO
    }
    
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        // TODO
    }
    
    
    
}
