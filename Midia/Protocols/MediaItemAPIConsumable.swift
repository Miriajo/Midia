//
//  MediaItemAPIConsumable.swift
//  Midia
//
//  Created by Miriam Sánchez on 3/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import Foundation


protocol MediaItemAPIConsumable {

    // A todo el que conforme este protocolo, le diremos que le vamos a preguntar por los últimos mediaItem y me tiene que devolver una lista de MediaItemProvidable
//    func getLatestMediaItems() -> [MediaItemProvidable]
    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void)
 
    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void)
    
    // búsqueda por ID para mostrar el detalle del artículo en pantalla
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void)
    
   
}
