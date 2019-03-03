//
//  HomeViewController.swift
//  Midia
//
//  Created by Casa on 26/2/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let mediaItemCellIdentifier = "mediaItemCell"
    
    var mediaItems: [MediaItemProvidable]! = [] // aquí nunca poner nada de Book, ni Movies ni nada, esto debe completarse fuera de aquí
    
    @IBOutlet weak var homeCollectionView: UICollectionView!

}

extension HomeViewController: UICollectionViewDelegate {
    

}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mediaItemCellIdentifier, for: indexPath) as? MediaItemCollectionViewCell else {
            fatalError()
        }
  
        let mediaItem = mediaItems[indexPath.item]
        
//        cell.titleLabel.text = mediaItem.title
        cell.mediaItem = mediaItem
        
        return cell
        
    }
    
}
