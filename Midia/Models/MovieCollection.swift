//
//  MovieCollection.swift
//  Midia
//
//  Created by Miriam Sánchez on 18/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import Foundation

struct MovieCollection {
    
    let resultCount: Int
    let results: [Movie]?
    
}

extension MovieCollection: Decodable {
    
}
