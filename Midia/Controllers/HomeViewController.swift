//
//  HomeViewController.swift
//  Midia
//
//  Created by Miriam Sánchez on 26/2/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import UIKit

enum MediaItemViewControllerState {
    case loading
    case noResults
    case failure
    case ready
}

class HomeViewController: UIViewController {
    
    let mediaItemCellIdentifier = "mediaItemCell"
    
    var mediaItemProvider: MediaItemProvider! 
    
    private var mediaItems: [MediaItemProvidable]! = [] // aquí nunca poner nada de Book, ni Movies ni nada, esto debe completarse fuera de aquí
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var failureEmojiLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var state: MediaItemViewControllerState = .ready {
        willSet {
            guard state != newValue else { return }
            
            // Ocultamos todas las vistas relacionadas con los estados y después mostramos las que corresponden
            [homeCollectionView, activityIndicatorView, failureEmojiLabel, statusLabel].forEach { (view) in
                view?.isHidden = true
            }
            
            // cuando ha cambiado, podemos actualizar la vista en función del estado en el que nos encontremos
            switch newValue {
            case .loading:
                activityIndicatorView.isHidden = false
            case .noResults:
                failureEmojiLabel.isHidden = false
                failureEmojiLabel.text = "🤭"
                statusLabel.isHidden = false
                statusLabel.text = "No hay nada que mostrar!!"
            case .failure:
                failureEmojiLabel.isHidden = false
                failureEmojiLabel.text = "❌"
                statusLabel.isHidden = false
                statusLabel.text = "Error conectando!!"
            case .ready:
                homeCollectionView.isHidden = false
                homeCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //activityIndicatorView.isHidden = false
        state = .loading
        
        mediaItemProvider.getHomeMediaItems(onSuccess: { [weak self] (mediaItems) in
            self?.mediaItems = mediaItems
//            self?.homeCollectionView.reloadData()
//            self?.activityIndicatorView.isHidden = true
            self?.state = mediaItems.count > 0 ? .ready : .noResults
                // la frase de arriba es lo mismo que el if-else de abajo
//            if mediaItems.count > 0 {
//                self?.state = .ready
//            } else {
//                self?.state = .noResults
//            }
        }) { [weak self] (error) in
//            self?.activityIndicatorView.isHidden = true
//            self?.failureEmojiLabel.isHidden = false
            self?.state = .failure
        }
    }

}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // creamos el Detail VC (desde un storyboard)
        guard let detailViewController = UIStoryboard(name: "Detail", bundle: nil).instantiateInitialViewController() as? DetailViewController else {
            fatalError()
        }
        
        // pasamos la info (id, mediaprovider)
        let mediaItem = mediaItems[indexPath.item]
        detailViewController.mediaItemId = mediaItem.mediaItemId
        detailViewController.mediaItemProvider = mediaItemProvider
        
        
        // mostramos (modalmente)
        present(detailViewController, animated: true, completion: nil)
        
    }
    
    

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
