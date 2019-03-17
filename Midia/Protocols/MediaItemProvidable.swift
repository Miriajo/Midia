//
//  MediaItemProvidable.swift
//  Midia
//
//  Created by Miriam Sánchez on 3/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import Foundation

protocol MediaItemProvidable {
    var mediaItemId: String { get }
    var title: String { get }
    var imageURL: URL? { get }
}
