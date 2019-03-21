//
//  DetailViewController.swift
//  Midia
//
//  Created by Miriam Sánchez on 5/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var creatorsLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var numberOfReviewsLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    @IBOutlet weak var ratingsContainerView: UIView!
    
    
    @IBOutlet weak var toggleFavoriteButton: UIButton!
    
    @IBOutlet weak var loadingView: UIView!
    
    var mediaItemId: String!
    var mediaItemProvider: MediaItemProvider! // debería ser opcional
    var detailedMediaItem: MediaItemDetailedProvidable?
    
    var isFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.isHidden = false
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        super.viewDidAppear(animated)
        
        // Buscarlo en favoritos primero, antes de buscarlo en internet
        if let favorite = StorageManager.shared.getFavorite(byId: mediaItemId) {
            detailedMediaItem = favorite
            syncViewWithModel()
            loadingView.isHidden = true
            isFavorite = true
            toggleFavoriteButton.setTitle("Remove favorite", for: .normal)
            
        } else {
            
            // pedirle al media provider el detalle del media item con el id recibido
            mediaItemProvider.getMediaItem(byId: mediaItemId, success: { [weak self] (detailedMediaItem) in
                self?.loadingView.isHidden = true
                
                // sincronizo la vista con el modelo
                self?.detailedMediaItem = detailedMediaItem
                self?.syncViewWithModel()
                
            }) { [weak self] (error) in
                self?.loadingView.isHidden = true
                
                // creo una alarma, le añado acción con el handler, presento la alarma
                let alertController = UIAlertController(title: nil, message: "Error recuperando media item.", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    self?.dismiss(animated: true, completion: nil)
                }))
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    
    private func syncViewWithModel() {
        guard let mediaItem = detailedMediaItem else {
            return
        }
        
        // Obligatorio
        titleLabel.text = mediaItem.title
        
        // Me vale que sea nil
        descriptionTextView.text = mediaItem.description
        
        // Stack view, si lo tenemos lo pintamos, si no ocultamos el elemento para que la stack view reorganice
        if let url = mediaItem.imageURL {
            imageView.loadImage(fromURL: url)
        }
        
        if let creators = mediaItem.creatorName {
            creatorsLabel.text = creators
        } else {
            creatorsLabel.isHidden = true
        }
        
        if let ratings = mediaItem.rating,
            let numberOfReviews = mediaItem.numberOfReviews {
            ratingLabel.text = "Rating \(ratings)"
            numberOfReviewsLabel.text = "\(numberOfReviews) reviews"
        } else {
            ratingsContainerView.isHidden = true
        }
        
        if let creationDate = mediaItem.creationDate {
            creationDateLabel.text = DateFormatter.shortAPIDateFormatter.string(from: creationDate)
        } else {
            creationDateLabel.isHidden = true
        }
        
        if let price = mediaItem.price {
            buyButton.setTitle("Buy for \(price)", for: .normal)
        } else {
            buyButton.isHidden = true
        }
        
    }
    
    
    // MARK: Actions
    @IBAction func didTapCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didTapToggleFavorite(_ sender: Any) {
        
        guard let favorite = detailedMediaItem else {
            return
        }
        
        isFavorite.toggle() // cambia el valor al contrario
        if isFavorite {
            StorageManager.shared.add(favorite: favorite)
            toggleFavoriteButton.setTitle("Remove favorite", for: .normal)
        } else {
            StorageManager.shared.remove(favoriteWithId: favorite.mediaItemId)
            toggleFavoriteButton.setTitle("Add favorite", for: .normal)
        }
    }
    
}
