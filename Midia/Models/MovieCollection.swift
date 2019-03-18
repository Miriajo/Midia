//
//  MovieCollection.swift
//  Midia
//
//  Created by Casa on 18/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation

struct MovieCollection {
    
    let resultCount: Int
    let results: [Movie]?
    
}

extension MovieCollection: Decodable {
    
}
