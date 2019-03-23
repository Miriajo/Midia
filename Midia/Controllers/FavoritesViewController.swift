//
//  FavoritesViewController.swift
//  Midia
//
//  Created by Miriam Sánchez on 11/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let favoriteCellReusedIdentifier = "favoriteCellReuseIdentifier"
    
    var favorites: [MediaItemDetailedProvidable] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Take favorites from the storage

        if let storeFavorites = MediaRepository.shared.storageManager.favorites?.getFavorites() {
            favorites = storeFavorites
            tableView.reloadData()
        }
    }

}

extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        // Create the Detail VC (from a storyboard)
        guard let detailViewController = UIStoryboard(name: "NewDetail", bundle: nil).instantiateInitialViewController() as? DetailViewController else {
            fatalError()
        }
        
        // pass the info (id, mediaprovider)
        let mediaItem = favorites[indexPath.row]
        detailViewController.mediaItemId = mediaItem.mediaItemId
        
        // show (modal)
        present(detailViewController, animated: true, completion: nil)
        
    }
    
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCellReusedIdentifier) as? FavoriteTableViewCell else {
            fatalError()
        }
        cell.mediaItem = favorites[indexPath.row]
        return cell
    }
    
    
}
