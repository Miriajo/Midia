//
//  Movie.swift
//  Midia
//
//  Created by Casa on 17/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation


struct Movie {
    
    let movieId: String
    let title: String
    let directors: [String]?
    let releaseDate: Date?
    let synopsis: String?
    let posterURL: URL?
    let rating: Float?
    let numberOfReviews: Int?
    let price: Float?
    
    init(movieId: String, title: String, directors: [String]? = nil, releaseDate: Date? = nil, synopsis: String? = nil, posterURL: URL? = nil, rating: Float? = nil, numberOfReviews: Int? = nil, price: Float? = nil) {
        self.movieId = movieId
        self.title = title
        self.directors = directors
        self.releaseDate = releaseDate
        self.synopsis = synopsis
        self.posterURL = posterURL
        self.rating = rating
        self.numberOfReviews = numberOfReviews
        self.price = price
    }
    
}


extension Movie: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case movieId = "trackId"
        case title = "trackName"
   //     case directors = "artistName"
   //     case releaseDate
   //     case synopsis = "longDescription"
   //     case posterURL = "artworkUrl100"
   //     case price = "trackHdPrice"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(String.self, forKey: .movieId)
        movieId = String(id)
                
        title = try container.decode(String.self, forKey: .title)
        
//        directors = try container.decodeIfPresent([String].self, forKey: .directors)
//
//        if let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
//            releaseDate = DateFormatter.booksAPIDateFormatter.date(from: releaseDateString)
//        } else {
//            releaseDate = nil
//        }
//
//        synopsis = try container.decodeIfPresent(String.self, forKey: .synopsis)
//
//        // El JSON no contiene estos datos, la API de iTunes no los devuelve
//        rating = nil
//        numberOfReviews = nil
//
//        posterURL = try container.decodeIfPresent(URL.self, forKey: .posterURL)
//
//        price = try container.decodeIfPresent(Float.self, forKey: .price)
        
        
        directors = nil
        releaseDate = nil
        synopsis = nil
        rating = nil
        numberOfReviews = nil
        posterURL = nil
        price = nil
        
    }
    
    
}


extension Movie: MediaItemProvidable {
    var mediaItemId: String {
        return movieId
    }
    
    var imageURL: URL? {
        return posterURL
    }
    
}
