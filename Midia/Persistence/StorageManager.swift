//
//  StorageManager.swift
//  Midia
//
//  Created by Casa on 11/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation

class StorageManager {
    
    static let shared: FavoritesProvidable = UserDefaultStorageManager(withMediaItemKind: .book)
   // static let shared: FavoritesProvidable = CoreDataStorageManager(withMediaItemKind: .book)
    
    
    
}
