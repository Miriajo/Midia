//
//  MediaItemDetailedProvidable.swift
//  Midia
//
//  Created by Miriam Sánchez on 6/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import Foundation

protocol MediaItemDetailedProvidable {
    
    var mediaItemId: String { get }
    var title: String { get }
    var imageURL: URL? { get }
    var creatorName: String? { get }
    var rating: Float? { get }
    var numberOfReviews: Int? { get }
    var creationDate: Date? { get }
    var price: Float? { get }
    var description: String? { get }

}
