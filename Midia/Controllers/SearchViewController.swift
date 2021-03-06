//
//  SearchViewController.swift
//  Midia
//
//  Created by Miriam Sánchez on 5/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    let mediaItemCellReuseIdentifier = "mediaItemIdentifier"
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var mediaItemProvider: MediaItemProvider!
    
    var mediaItems: [MediaItemProvidable] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mediaItemProvider = MediaItemProvider(withMediaItemKind: MediaRepository.shared.mediaItemProvider.mediaItemKind)
            
            self.searchBar.text = ""
            self.mediaItems = []
            self.collectionView.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        searchBar.delegate = self
    }
    
}

extension SearchViewController: UICollectionViewDelegate {

    // When user selects a cell, we show the detail of media item
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

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mediaItemCellReuseIdentifier, for: indexPath) as? MediaItemCollectionViewCell else {
            fatalError("Unexpected cell type")
        }
        let mediaItem = mediaItems[indexPath.item]
        cell.mediaItem = mediaItem
        return cell
    }
    
}

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Make the search, show results
        
        guard let queryParams = searchBar.text, !queryParams.isEmpty else {
            return
        }
        
        activityIndicator.isHidden = false
        
        mediaItemProvider.getSearchMediaItems(withQueryParams: queryParams, success: { [weak self] (mediaItems) in
        
            self?.mediaItems = mediaItems
            self?.collectionView.reloadData()
            self?.activityIndicator.isHidden = true
            
        }) { (error) in
            // TODO
        }
        
    }

}
