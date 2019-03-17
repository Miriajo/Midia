//
//  UIImageView+Networking.swift
//  Midia
//
//  Created by Casa on 5/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(fromURL url: URL) {
        
        // no devuelve nada porque tiene que ejecutarse en background
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }                 
                }
            }
        }
    }
    
    
}
