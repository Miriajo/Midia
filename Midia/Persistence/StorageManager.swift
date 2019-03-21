//
//  StorageManager.swift
//  Midia
//
//  Created by Miriam Sánchez on 11/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import Foundation

class StorageManager {
    
    //static let shared: FavoritesProvidable = UserDefaultStorageManager(withMediaItemKind: .book)
   //static let shared: FavoritesProvidable = CoreDataStorageManager(withMediaItemKind: .book)
   // static let shared: FavoritesProvidable = UserDefaultStorageManager(withMediaItemKind: .movie)
    static let shared: FavoritesProvidable = CoreDataStorageManager(withMediaItemKind: .movie)
        
}
