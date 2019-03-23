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
    
    private var mediaItems: [MediaItemProvidable]! = [] // Never write any Book or other, it should be completed outside
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var failureEmojiLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var state: MediaItemViewControllerState = .ready {
        willSet {
            guard state != newValue else { return }
            
            // Hide all views related with status and later show which are needed
            [homeCollectionView, activityIndicatorView, failureEmojiLabel, statusLabel].forEach { (view) in
                view?.isHidden = true
            }
            
            // When it have changed, we can update the view taking into account the status
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mediaItemProvider = MediaItemProvider(withMediaItemKind: MediaRepository.shared.mediaItemProvider.mediaItemKind)
        
        self.state = .loading
        
        self.mediaItemProvider.getHomeMediaItems(onSuccess: { [weak self] (mediaItems) in
            self?.mediaItems = mediaItems
            self?.state = mediaItems.count > 0 ? .ready : .noResults
          
        }) { [weak self] (error) in
            self?.state = .failure
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        state = .loading
        
        mediaItemProvider.getHomeMediaItems(onSuccess: { [weak self] (mediaItems) in
            self?.mediaItems = mediaItems
            self?.state = mediaItems.count > 0 ? .ready : .noResults
        }) { [weak self] (error) in
            self?.state = .failure
        }
    }

}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // create the Detail VC (from a storyboard)
        guard let detailViewController = UIStoryboard(name: "NewDetail", bundle: nil).instantiateInitialViewController() as? DetailViewController else {
            fatalError()
        }
        
        // pass the info (id, mediaprovider)
        let mediaItem = mediaItems[indexPath.item]
        detailViewController.mediaItemId = mediaItem.mediaItemId
        detailViewController.mediaItemProvider = mediaItemProvider
        
        
        // show (modal)
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
        
        cell.mediaItem = mediaItem
        
        return cell
        
    }
    
}
