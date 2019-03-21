//
//  UserDefaultStorageManager.swift
//  Midia
//
//  Created by Miriam Sánchez on 11/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import Foundation

class UserDefaultStorageManager: FavoritesProvidable {

    let userDefaults = UserDefaults.standard
    
    let mediaItemKind: MediaItemKind
    let favoritesKey: String
    
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    init(withMediaItemKind mediaItemKind: MediaItemKind) {
        self.mediaItemKind = mediaItemKind
        self.favoritesKey = "favorite \(mediaItemKind)"
    }
    
    
    func getFavorites() -> [MediaItemDetailedProvidable]? {
        
        if let favoritesData = userDefaults.data(forKey: favoritesKey) {
            switch mediaItemKind {
                case .book:
                    return try? decoder.decode([Book].self, from: favoritesData)
                case .movie:
                    return try? decoder.decode([Movie].self, from: favoritesData)
                default:
                    fatalError("Media kind `\(mediaItemKind)` not supported yet")
            }
        }
         return nil
    }
    
    func getFavorite(byId favoriteId: String) -> MediaItemDetailedProvidable? {
        
        var retrieved: MediaItemDetailedProvidable? = nil
        
        if let favorites = getFavorites() {
            retrieved = favorites.filter({ $0.mediaItemId == favoriteId }).first
        }
        return retrieved
        
    }
    
    func add(favorite: MediaItemDetailedProvidable) {
     
        guard getFavorite(byId: favorite.mediaItemId) == nil else {
            return
        }
        
        if var favorites = getFavorites() {
            favorites.append(favorite)
            // guardar
            save(favorites)
        } else {
            // guardar [favorite]
            save([favorite])
        }
        
    }
    
    func remove(favoriteWithId favoriteId: String) {
    
        if var favorites = getFavorites() {
            for (index, favorite) in favorites.enumerated() {
                if favoriteId == favorite.mediaItemId {
                    favorites.remove(at: index)
                    save(favorites)
                }
            }
        }
        
    }
    
    private func save(_ favorites: [MediaItemDetailedProvidable]) {
        do {
            switch  mediaItemKind {
            case .book:
//                userDefaults.set(try encoder.encode(favorites as! [Book]), forKey: favoritesKey)

                // salvar sin forzar el cast
                if let books = favorites as? [Book] {
                    userDefaults.set(try encoder.encode(books), forKey: favoritesKey)
                }
            case .movie:
                if let movies = favorites as? [Movie] {
                    userDefaults.set(try encoder.encode(movies), forKey: favoritesKey)
                }
            default:
                fatalError("not supported yet")
            }
            userDefaults.synchronize()
        } catch {
            fatalError("error encoding favorites")
        }
    }
    
    
}
