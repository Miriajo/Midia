//
//  Constants.swift
//  Midia
//
//  Created by Miriam Sánchez on 4/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import Foundation

struct GoogleBooksAPIConstants {
    
    private static let apiKey = getAPIKey()
    
    static func getAbsoluteURL(withQueryParams queryParams: [String]) -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes"
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        components.queryItems?.append(URLQueryItem(name: "q", value: queryParams.joined(separator: "+")))
        
        return components.url!
    }
    
    static func urlForBook(withId bookId: String) -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes/\(bookId)"
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        
        return components.url!
    }
    
}

struct ITunesMoviesAPIConstants {
    
    static func getITunesAbsoluteURL(withQueryParams queryParams: [String]) -> URL {
    
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        components.queryItems = [URLQueryItem(name: "media", value: "movie"), URLQueryItem(name: "attribute", value: "movieTerm"), URLQueryItem(name: "country", value: "es")]
        components.queryItems?.append(URLQueryItem(name: "term", value: queryParams.joined(separator: "+")))
    
        return components.url!
    
    }
    
    static func urlForMovie(withId movieId: String) -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/lookup"
        components.queryItems = [URLQueryItem(name: "id", value: movieId), URLQueryItem(name: "country", value: "es")]
        
        return components.url!
    }
    
}


private func getAPIKey() -> String {
    
    var resourceFileDictionary: NSDictionary?
    
    var apiKey: String = ""
    
    // Cargar el contenido del Info.plist en el diccionary resourceFileDictionary
    if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
        resourceFileDictionary = NSDictionary(contentsOfFile: path)
    }
    
    if let resourceFileDictionaryContent = resourceFileDictionary {
        
        // Coger el valor apiKey del Info.plist
        apiKey = resourceFileDictionaryContent.object(forKey: "apiKey")! as! String
        
    }
    
    return apiKey
}
