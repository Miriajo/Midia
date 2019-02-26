//
//  Book.swift
//  Midia
//
//  Created by Miriam Sánchez on 2/25/19.
//  Copyright © 2019 Casa. All rights reserved.
//

import Foundation

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

}

extension Book: Decodable {

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
            publishedDate = DateFormatter.booksAPIDateFormatter.date(from: publishedDateString)
        } else {
            publishedDate = nil
        }
        
        description = try volumeInfoContainer.decodeIfPresent(String.self, forKey: .description)
        
        // Convertir un String en URL
        //do {
            // si ponemos el try? indicamos que es opcional y no hace falta el do-catch
            let imageLinkContainer = try? volumeInfoContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .imageLinks)
            coverURL = try imageLinkContainer?.decodeIfPresent(URL.self, forKey: .coverURL)
//        } catch {
//            coverURL = nil
//        }
        
        rating = try volumeInfoContainer.decodeIfPresent(Float.self, forKey: .rating)
        numberOfReviews = try volumeInfoContainer.decodeIfPresent(Int.self, forKey: .numberOfReviews)
        
        let saleInfoContainer = try? container.nestedContainer(keyedBy: CodingKeys.self, forKey: .saleInfo)
        let listPriceContainer = try? saleInfoContainer?.nestedContainer(keyedBy: CodingKeys.self, forKey: .listPrice)
        price = try listPriceContainer??.decodeIfPresent(Float.self, forKey: .price)
    }

}
