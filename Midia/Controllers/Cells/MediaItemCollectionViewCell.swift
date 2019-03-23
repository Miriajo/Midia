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
     
    // We have a property - my model
    var mediaItem: MediaItemProvidable! {
        didSet {
            // make whatever it wants when attribute changes
            // with willSet I do whatever I want BEFORE attribute value changes
            titleLabel.text = mediaItem.title
            if let url = mediaItem.imageURL {
               
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.sd_cancelCurrentImageLoad()
        
    }
    
}


