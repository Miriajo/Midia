//
//  DateFormatter+Custom.swift
//  Midia
//
//  Created by Miriam Sánchez on 26/2/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    // Constante estática de clase - Propiedad computada
    static let shortAPIDateFormatter: DateFormatter = {
        // Le asignamos un closure que devuelve un formato
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }() // los paréntesis del final es para que se ejecute

    static let longAPIDateFormatter: DateFormatter = {
       
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
}


