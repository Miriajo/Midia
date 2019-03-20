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
    var directors: [String]?
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
        case directors = "artistName"
        case releaseDate
        case synopsis = "longDescription"
        case posterURL = "artworkUrl100"
        case price = "trackHdPrice"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try container.decode(Int.self, forKey: .movieId)
        movieId = String(id)
                
        title = try container.decode(String.self, forKey: .title)
        
        let artists = try container.decodeIfPresent(String.self, forKey: .directors)
        
        directors = artists?.components(separatedBy: ", ")
        
        if let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
            releaseDate = DateFormatter.booksAPIDateFormatter.date(from: releaseDateString)
        } else {
            releaseDate = nil
        }

        synopsis = try container.decodeIfPresent(String.self, forKey: .synopsis)

        // El JSON no contiene estos datos, la API de iTunes no los devuelve
        rating = nil
        numberOfReviews = nil

        posterURL = try container.decodeIfPresent(URL.self, forKey: .posterURL)

        price = try container.decodeIfPresent(Float.self, forKey: .price)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(movieId, forKey: .movieId)
        
        try container.encode(title, forKey: .title)
        
        try container.encodeIfPresent(directors, forKey: .directors)
        
        if let date = releaseDate {
            try container.encode(DateFormatter.booksAPIDateFormatter.string(from: date), forKey: .releaseDate)
        }
        
        try container.encodeIfPresent(synopsis, forKey: .synopsis)
        
        try container.encodeIfPresent(posterURL, forKey: .posterURL)
        
        try container.encodeIfPresent(price, forKey: .price)
        
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


extension Movie: MediaItemDetailedProvidable {
    var creatorName: String? {
        return directors?.joined(separator: ", ")
    }
    
    var creationDate: Date? {
        return releaseDate
    }
    
    var description: String? {
        return synopsis
    }

}
