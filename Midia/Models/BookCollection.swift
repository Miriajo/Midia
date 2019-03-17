//
//  BookCollection.swift
//  Midia
//
//  Created by Miriam Sánchez on 2/25/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import Foundation

struct BookCollection {

    let kind: String
    let totalItems: Int
    let items: [Book]?

}

extension BookCollection: Decodable {

    
}
