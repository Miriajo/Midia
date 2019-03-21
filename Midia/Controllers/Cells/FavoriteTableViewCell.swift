//
//  FavoriteTableViewCell.swift
//  Midia
//
//  Created by Miriam Sánchez on 11/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import UIKit
import SDWebImage


class FavoriteTableViewCell: UITableViewCell {
    

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorsLabel: UILabel!
    @IBOutlet weak var createdOnLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var mediaItem: MediaItemDetailedProvidable! {
        
        didSet {
            
            if let url = mediaItem.imageURL {
                coverImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
            }
            
            titleLabel.text = mediaItem.title

            // OPCIONALES - queremos ocultarlos cuando estén vacíos
            if let creators = mediaItem.creatorName {
                creatorsLabel.text = creators
            } else {
                creatorsLabel.isHidden = true
            }
            if let dated = mediaItem.creationDate {
                createdOnLabel.text = "fecha: \(DateFormatter.shortAPIDateFormatter.string(from: dated))"
            } else {
                createdOnLabel.isHidden = true
            }
            if let price = mediaItem.price {
                priceLabel.text = "Precio: \(price)$"
            } else {
                priceLabel.isHidden = true
            }
            
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        coverImageView.sd_cancelCurrentImageLoad()
        [creatorsLabel, createdOnLabel, priceLabel].forEach ({ $0?.isHidden = false })
    }
    
    
}


