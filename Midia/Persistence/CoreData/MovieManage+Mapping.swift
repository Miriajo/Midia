//
//  MovieManage+Mapping.swift
//  Midia
//
//  Created by Casa on 21/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation

extension MovieManaged {
    
    func mappedObject() -> Movie {
       
        let directorsList = movieDirectors?.map({ (director) -> String in
            let director = director as! Director
            return director.fullName!
        })

        let url: URL? = posterURL != nil ? URL(string: posterURL!) : nil

        return Movie(movieId: Int(movieId), title: movieTitle!, directors: directorsList, releaseDate: releaseDate, synopsis: movieDesc, posterURL: url, rating: rating, numberOfReviews: Int(numberOfReviews), price: price)
        
    }
    
}
