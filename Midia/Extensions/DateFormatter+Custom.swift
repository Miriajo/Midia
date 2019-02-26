//
//  DateFormatter+Custom.swift
//  Midia
//
//  Created by Casa on 26/2/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    // Constante estática de clase - Propiedad computada
    static let booksAPIDateFormatter: DateFormatter = {
        // Le asignamos un closure que devuelve un formato
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }() // los paréntesis del final es para que se ejecute
        
}
