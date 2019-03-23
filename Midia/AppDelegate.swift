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
         guard let tabBarController = window?.rootViewController as? UITabBarController,
            let homeViewController = tabBarController.viewControllers?.first as? HomeViewController,
            let searchViewController = tabBarController.viewControllers?[1] as? SearchViewController
        else {
            fatalError("Wrong initial setup")
        }
        
        // We have a service to send the mediaItem type to who want to show the results and say to my homeScreen: here are the last resutls
  
        // init value for viewControllers with MediaRepository
        homeViewController.mediaItemProvider = MediaRepository.shared.mediaItemProvider
        searchViewController.mediaItemProvider = MediaRepository.shared.mediaItemProvider
        
        
        return true
    }

}


