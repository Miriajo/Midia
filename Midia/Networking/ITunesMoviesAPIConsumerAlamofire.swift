//
//  ITunesMoviesAPIConsumerAlamofire.swift
//  Midia
//
//  Created by Miriam Sánchez on 19/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import Foundation
import Alamofire

class ITunesMoviesAPIConsumerAlamofire: MediaItemAPIConsumable {
    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        
        Alamofire.request(ITunesMoviesAPIConstants.getITunesAbsoluteURL(withQueryParams: ["silencio"])).responseData { (response) in
            
            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: value)
                    success(movieCollection.results ?? [])
                } catch {
                    failure(error)
                }
            }
        }
        
        
    }
    
    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        
        let paramsList = queryParams.components(separatedBy: " ")
        
        Alamofire.request(ITunesMoviesAPIConstants.getITunesAbsoluteURL(withQueryParams: paramsList)).responseData { (response) in
            
            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: value)
                    success(movieCollection.results ?? [])
                } catch {
                    failure(error)
                }
            }
        }
        
        
    }
    
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        
        Alamofire.request(ITunesMoviesAPIConstants.urlForMovie(withId: mediaItemId)).responseData { (response) in
            
            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let movie = try decoder.decode(MovieCollection.self, from: value)
                    success((movie.results?[0])!)
                } catch {
                    failure(error)
                }
            }
        }
        
        
    }
    
}
