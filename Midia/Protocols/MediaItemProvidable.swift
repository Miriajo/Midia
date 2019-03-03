//
//  MediaItemProvidable.swift
//  Midia
//
//  Created by Casa on 3/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation

protocol MediaItemProvidable {
    var title: String { get }
    var imageURL: URL? { get }
}
