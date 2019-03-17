//
//  MediaItemCollectionViewCell.swift
//  Midia
//
//  Created by Miriam Sánchez on 3/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import UIKit
import SDWebImage

class MediaItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
     
    // Tengo una propiedad que es mi modelo
    var mediaItem: MediaItemProvidable! {
        didSet {
            // hacer lo que quiera cuando cambie el atributo
            // con willSet hago lo que quiera ANTES de que cambie el valor del atributo
            titleLabel.text = mediaItem.title
            if let url = mediaItem.imageURL {
                //imageView.loadImage(fromURL: url)
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.sd_cancelCurrentImageLoad()
        
    }
    
}


