//
//  MediaItemAPIConsumable.swift
//  Midia
//
//  Created by Casa on 3/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation


protocol MediaItemAPIConsumable {

    // A todo el que conforme este protocolo, le diremos que le vamos a preguntar por los últimos mediaItem y me tiene que devolver una lista de MediaItemProvidable
//    func getLatestMediaItems() -> [MediaItemProvidable]
    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void)
    
}
