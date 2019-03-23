//
//  DateFormatter+Custom.swift
//  Midia
//
//  Created by Miriam Sánchez on 26/2/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    // Static constant of class - Computed property
    static let shortAPIDateFormatter: DateFormatter = {
        // Assing a closure returning a format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }() // parenthesis at the end are to execute
    
    static let longAPIDateFormatter: DateFormatter = {
       
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
}


