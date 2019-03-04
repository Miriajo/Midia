//
//  MediaItemCollectionViewCell.swift
//  Midia
//
//  Created by Casa on 3/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import UIKit

class MediaItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
     
    // Tengo una propiedad que es mi modelo
    var mediaItem: MediaItemProvidable! {
        didSet {
            // hacer lo que quiera cuando cambie el atributo
            // con willSet hago lo que quiera ANTES de que cambie el valor del atributo
            titleLabel.text = mediaItem.title
            // TODO: poner imagen
        }
    }
    
}


