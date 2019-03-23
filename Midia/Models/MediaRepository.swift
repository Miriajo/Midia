//
//  MediaRepository.swift
//  Midia
//
//  Created by Miriam Sánchez on 22/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import Foundation


class MediaRepository {
    
    static let shared: MediaRepository = MediaRepository(type: .book)
    
    let storageManager: StorageManager
    let mediaItemProvider: MediaItemProvider
    var type: MediaItemKind {
        didSet {
            storageManager.mediaItemKind = type
            mediaItemProvider.mediaItemKind = type
        }
    }
    
    private init(type: MediaItemKind) {
        self.type = type
        
        storageManager = StorageManager()
        storageManager.mediaItemKind = type
        
        mediaItemProvider = MediaItemProvider(withMediaItemKind: type)
        
    }
    
}
