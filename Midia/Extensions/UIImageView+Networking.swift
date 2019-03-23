//
//  UIImageView+Networking.swift
//  Midia
//
//  Created by Miriam Sánchez on 5/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(fromURL url: URL) {
        
        // it doesn't return anything because it has to be executed in background mode
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
