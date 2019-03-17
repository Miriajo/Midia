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
    let releasedDate: Date?
    let synopsis: String?
    let posterURL: URL?
    let rating: Float?
    let numberOfReviews: Int?
    let price: Float?
    
    init(movieId: String, title: String, directors: [String]? = nil, releasedDate: Date? = nil, synopsis: String? = nil, posterURL: URL? = nil, rating: Float? = nil, numberOfReviews: Int? = nil, price: Float? = nil) {
        self.movieId = movieId
        self.title = title
        self.directors = directors
        self.releasedDate = releasedDate
        self.synopsis = synopsis
        self.posterURL = posterURL
        self.rating = rating
        self.numberOfReviews = numberOfReviews
        self.price = price
    }
    
}
