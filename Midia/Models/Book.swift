//
//  Book.swift
//  Midia
//
//  Created by Miriam Sánchez on 2/25/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import Foundation
import CoreData

struct Book {

    let bookId: String
    let title: String
    let authors: [String]?
    let publishedDate: Date?
    let description: String?
    let coverURL: URL?
    let rating: Float?
    let numberOfReviews: Int?
    let price: Float?

    init(bookId: String, title: String, authors: [String]? = nil, publishedDate: Date? = nil, description: String? = nil, coverURL: URL? = nil, rating: Float? = nil, numberOfReviews: Int? = nil, price: Float? = nil) {
        self.bookId = bookId
        self.title = title
        self.authors = authors
        self.publishedDate = publishedDate
        self.description = description
        self.coverURL = coverURL
        self.rating = rating
        self.numberOfReviews = numberOfReviews
        self.price = price
    }
    
}

extension Book: Codable {

    enum CodingKeys: String, CodingKey {
        case bookId = "id"
        case volumeInfo
        case title
        case authors
        case publishedDate
        case description
        case imageLinks
        case coverURL = "thumbnail"
        case rating = "averageRating"
        case numberOfReviews = "ratingsCount"
        case saleInfo
        case listPrice
        case price = "amount"
    }

    init(from decoder: Decoder) throws { //throws evita que todo lo que pongas con try lo tengas que poner dentro de un do-catch. THROWS ya especifica que va a recoger errores
        let container = try decoder.container(keyedBy: CodingKeys.self)

        bookId = try container.decode(String.self, forKey: .bookId)

        let volumeInfoContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .volumeInfo)
        title = try volumeInfoContainer.decode(String.self, forKey: .title)

        // decodeIfPresent es porque es opcional
        authors = try volumeInfoContainer.decodeIfPresent([String].self, forKey: .authors)
        
        // Formatear la fecha desde el String con la extension que hemos creado
        if let publishedDateString = try volumeInfoContainer.decodeIfPresent(String.self, forKey: .publishedDate) {
            publishedDate = DateFormatter.shortAPIDateFormatter.date(from: publishedDateString)
        } else {
            publishedDate = nil
        }
        
        description = try volumeInfoContainer.decodeIfPresent(String.self, forKey: .description)
        
        // Convertir un String en URL
             // si ponemos el try? indicamos que es opcional y no hace falta el do-catch
            let imageLinkContainer = try? volumeInfoContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageLinks)
            coverURL = try imageLinkContainer?.decodeIfPresent(URL.self, forKey: .coverURL)
       
        rating = try volumeInfoContainer.decodeIfPresent(Float.self, forKey: .rating)
        numberOfReviews = try volumeInfoContainer.decodeIfPresent(Int.self, forKey: .numberOfReviews)
        
        let saleInfoContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .saleInfo)
        let listPriceContainer = try? saleInfoContainer?.nestedContainer(keyedBy: CodingKeys.self, forKey: .listPrice)
        price = try listPriceContainer??.decodeIfPresent(Float.self, forKey: .price)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(bookId, forKey: .bookId)
        
        var volumeInfoContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .volumeInfo)
        try volumeInfoContainer.encode(title, forKey: .title)
        try volumeInfoContainer.encodeIfPresent(authors, forKey: .authors)
        if let date = publishedDate {
            try volumeInfoContainer.encode(DateFormatter.shortAPIDateFormatter.string(from: date), forKey: .publishedDate)
        }
        try volumeInfoContainer.encodeIfPresent(description, forKey: .description)
        
        var imageLinksContainer = volumeInfoContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageLinks)
        try imageLinksContainer.encodeIfPresent(coverURL, forKey: .coverURL)
        
        try volumeInfoContainer.encodeIfPresent(rating, forKey: .rating)
        try volumeInfoContainer.encodeIfPresent(numberOfReviews, forKey: .numberOfReviews)
        
        var saleInfoContainer = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .saleInfo)
        var listPriceContainer = saleInfoContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .listPrice)
        try listPriceContainer.encodeIfPresent(price, forKey: .price)
        
    }
    
}

extension Book: MediaItemProvidable {
    var mediaItemId: String {
        return bookId
    }
    
    var imageURL: URL? {
        return coverURL
    }
}

extension Book: MediaItemDetailedProvidable {
    var creatorName: String? {
        return authors?.joined(separator: ", ")  // [Patrick, Juan] -> Patrick, Juan
    }
    
    var creationDate: Date? {
        return publishedDate
    }
    
    
}
