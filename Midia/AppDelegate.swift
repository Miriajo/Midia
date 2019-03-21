//
//  AppDelegate.swift
//  Midia
//
//  Created by Miriam Sánchez on 2/25/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //guard let homeViewController = window?.rootViewController as? HomeViewController else {
        guard let tabBarController = window?.rootViewController as? UITabBarController,
            let homeViewController = tabBarController.viewControllers?.first as? HomeViewController,
            let searchViewController = tabBarController.viewControllers?[1] as? SearchViewController else {
            fatalError("Wrong initial setup")
        }
        
        // Tener un servicio que le diga el tipo de mediaItem que quiera mostrar y le diga a mi homeScreen - oye, muestra los últimos estrenos
        // let mediaProvider = MediaItemProvider(withMediaItemKind: .book)
        // homeViewController.mediaItems = mediaProvider.getHomeMediaItems()
        let currentMediaItemProvider = MediaItemProvider(withMediaItemKind: .movie)
        homeViewController.mediaItemProvider = currentMediaItemProvider
        searchViewController.mediaItemProvider = currentMediaItemProvider
        
        
        // Cargar los favoritos
        //StorageManager.shared.add(favorite: Book(bookId: "1", title: "HOLA MUNDO FAVORITOS"))
        StorageManager.shared.add(favorite: Movie(movieId: 3, title: "HOLA MUNDO FAVORITOS"))
        
        return true
    }

}


