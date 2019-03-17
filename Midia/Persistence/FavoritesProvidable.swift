//
//  FavoritesProvidable.swift
//  Midia
//
//  Created by Casa on 11/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation

protocol FavoritesProvidable {
    
    func getFavorites() -> [MediaItemDetailedProvidable]?
    func getFavorite(byId favoriteId: String) -> MediaItemDetailedProvidable?
    func add(favorite: MediaItemDetailedProvidable)
    func remove(favoriteWithId favoriteId: String)
    
    
    
}
