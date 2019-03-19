//
//  ITunesMoviesAPIConsumerAlamofire.swift
//  Midia
//
//  Created by Casa on 19/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation
import Alamofire

class ITunesMoviesAPIConsumerAlamofire: MediaItemAPIConsumable {
    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        
        Alamofire.request(ITunesMoviesAPIConstants.getITunesAbsoluteURL(withQueryParams: ["silencio"])).responseData { (response) in
            
            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(_):
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                        success(movieCollection.results ?? [])
                    } catch {
                        failure(error)
                    }
                } else {
                    success([])
                }
            }
            
        }
        
        
    }
    
    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        // TODO
    }
    
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        // TODO
    }
    
}
