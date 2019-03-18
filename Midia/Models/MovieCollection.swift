//
//  MovieCollection.swift
//  Midia
//
//  Created by Casa on 18/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation

struct MovieCollection {
    
    let kind: String
    let totalItems: Int
    let items: [Movie]?
    
}

extension MovieCollection: Decodable {
    
}
