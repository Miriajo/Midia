//
//  CoreDataStack.swift
//  Midia
//
//  Created by Casa on 17/3/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let sharedInstance = CoreDataStack()
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Error loading persistent stores: \(error)")
            }
        })
        return container
    }()
    
    
}


