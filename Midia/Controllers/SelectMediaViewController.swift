//
//  SelectMediaViewController.swift
//  Midia
//
//  Created by Miriam Sánchez on 22/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import UIKit

class SelectMediaViewController: UIViewController {
  
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var movieButton: UIButton!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    
    // MARK: Actions
    
    @IBAction func bookSelectButton(_ sender: UIButton) {
    
        if bookButton.backgroundColor != UIColor.orange {
            
            // Change background colour and load Books as Media
            let greyBGColor = bookButton.backgroundColor!
            bookButton.backgroundColor = UIColor.orange
            movieButton.backgroundColor = greyBGColor
            
            MediaRepository.shared.type = .book
            
        }
        
    }
    
    @IBAction func movieSelectButton(_ sender: UIButton) {
    
        if movieButton.backgroundColor != UIColor.orange {
            
            // Change background colour and load Movies as Media
            let greyBGColor = movieButton.backgroundColor!
            movieButton.backgroundColor = UIColor.orange
            bookButton.backgroundColor = greyBGColor
            
            MediaRepository.shared.type = .movie
            
        }
        
    }
    
}
