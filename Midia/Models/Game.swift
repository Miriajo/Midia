//
//  Game.swift
//  Midia
//
//  Created by Casa on 3/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation

struct Game: MediaItemProvidable, MediaItemDetailedProvidable {
    
    
    let mediaItemId: String = "12345"
    
    let title: String = "A game"
    let imageURL: URL? = nil

    let creatorName: String? = nil
    let rating: Float? = nil
    let numberOfReviews: Int? = nil
    let creationDate: Date? = nil
    let price: Float? = nil
    let description: String? = nil
}


