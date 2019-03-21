//
//  CoreDataStorageManager.swift
//  Midia
//
//  Created by Miriam Sánchez on 12/3/19.
//  Copyright © 2019 Miriam Sánchez. All rights reserved.
//

import Foundation
import CoreData

// TODO: capa de abstracción para usar siempre media items

class CoreDataStorageManager: FavoritesProvidable {

    let mediaItemKind: MediaItemKind
    let stack = CoreDataStack.sharedInstance
    
    
    init(withMediaItemKind mediaItemKind: MediaItemKind) {
        self.mediaItemKind = mediaItemKind
    }

    func getFavorites() -> [MediaItemDetailedProvidable]? {
        
        // crear un contexto de hilo principal
        let context = stack.persistentContainer.viewContext
        
        switch mediaItemKind {
        case .book:
            // Query al Storage
            let fetchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
            
            // ordenar los resultados por fecha de publicación y precio
            let dateSortDescriptor: NSSortDescriptor = NSSortDescriptor(key: "publishedDate", ascending: true)
            let priceSortDescriptor = NSSortDescriptor(key: "price", ascending: false)
            fetchRequest.sortDescriptors = [dateSortDescriptor, priceSortDescriptor]
            
            // ejecutar la Query
            do {
                
                let favorites = try context.fetch(fetchRequest)
                
                return favorites.map({ $0.mappedObject() })
                
                
            } catch {
                assertionFailure("Error fetching media items")
                return nil
            }
        case .movie:
            // Query al Storage
            let fetchRequest: NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
            
            // ordenar los resultados por fecha de publicación y precio
            let dateSortDescriptor: NSSortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
            let priceSortDescriptor = NSSortDescriptor(key: "price", ascending: false)
            fetchRequest.sortDescriptors = [dateSortDescriptor, priceSortDescriptor]
            
            // ejecutar la Query
            do {
                
                let favorites = try context.fetch(fetchRequest)
                
                return favorites.map({ $0.mappedObject() })
                
                
            } catch {
                assertionFailure("Error fetching media items")
                return nil
            }
        default:
            assertionFailure("Error fetching media items")
            return nil
        }
        
        

    }
    
    func getFavorite(byId favoriteId: String) -> MediaItemDetailedProvidable? {
     
        let context = stack.persistentContainer.viewContext
        
        switch mediaItemKind {
        case .book:
            // Query al Storage
            let fetchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
            
            let predicate: NSPredicate = NSPredicate(format: "bookId = %@", favoriteId)
            
            fetchRequest.predicate = predicate
            
            // ejecutar la Query
            do {
                
                let favorites = try context.fetch(fetchRequest)
                
                return favorites.last?.mappedObject()
                
                
            } catch {
                assertionFailure("Error fetching media item by id \(favoriteId)")
                return nil
            }
        case .movie:
            // Query al Storage
            let fetchRequest: NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
            
            let predicate: NSPredicate = NSPredicate(format: "movieId = %@", favoriteId)
            
            fetchRequest.predicate = predicate
            
            // ejecutar la Query
            do {
                
                let favorites = try context.fetch(fetchRequest)
                
                return favorites.last?.mappedObject()
                
                
            } catch {
                assertionFailure("Error fetching media item by id \(favoriteId)")
                return nil
            }
        default:
            assertionFailure("Error fetching media items")
            return nil
        }
            
    }
    
    func add(favorite: MediaItemDetailedProvidable) {
       
        let context = stack.persistentContainer.viewContext
        
        
        if let book = favorite as? Book {
            
            let bookManaged = BookManaged(context: context)
            bookManaged.bookId = book.bookId
            bookManaged.bookTitle = book.title
            bookManaged.publishedDate = book.publishedDate
            bookManaged.coverURL = book.coverURL?.absoluteString
            bookManaged.bookDescription = book.description
            if let rating = book.rating {
                bookManaged.rating = rating
            }
            if let numberOfReviews = book.numberOfReviews {
                bookManaged.numberOfReviews = Int32(numberOfReviews)
            }
            if let price = book.price {
                bookManaged.price = price
            }
            book.authors?.forEach({ (authorName) in
                let author = Author(context: context)
                author.fullName = authorName
                bookManaged.addToAuthors(author)
            })
            
            do {
                
                try context.save()
                
            } catch {
                assertionFailure("error saving context")
            }
            
        } else if let movie = favorite as? Movie {
            
            let movieManaged = MovieManaged(context: context)
            movieManaged.movieId = Int32(movie.movieId)
            movieManaged.movieTitle = movie.title
            movieManaged.releaseDate = movie.releaseDate
            movieManaged.posterURL = movie.posterURL?.absoluteString
            movieManaged.movieDesc = movie.synopsis
            if let rating = movie.rating {
                movieManaged.rating = rating
            }
            if let numberOfReviews = movie.numberOfReviews {
                movieManaged.numberOfReviews = Int32(numberOfReviews)
            }
            if let price = movie.price {
                movieManaged.price = price
            }
            movie.directors?.forEach({ (directorName) in
                let director = Director(context: context)
                director.fullName = directorName
                movieManaged.addToMovieDirectors(director)
            })
            
            do {
                
                try context.save()
                
            } catch {
                assertionFailure("error saving context")
            }
        
            
        } else {
            fatalError("Not supported yet :(")
        }
        
    }
    
    func remove(favoriteWithId favoriteId: String) {
      
        let context = stack.persistentContainer.viewContext
        
        
        switch mediaItemKind {
        case .book:
            // Query al Storage
            let fetchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
            
            let predicate: NSPredicate = NSPredicate(format: "bookId = %@", favoriteId)
            
            fetchRequest.predicate = predicate
            
            do {
                let favorites = try context.fetch(fetchRequest)
                favorites.forEach({ (bookManaged) in
                    context.delete(bookManaged)
                })
                try context.save()
                
            } catch {
                assertionFailure("Error removing media item with id \(favoriteId)")
            }
        case .movie:
            // Query al Storage
            let fetchRequest: NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
            
            let predicate: NSPredicate = NSPredicate(format: "movieId = %@", favoriteId)
            
            fetchRequest.predicate = predicate
            
            do {
                let favorites = try context.fetch(fetchRequest)
                favorites.forEach({ (movieManaged) in
                    context.delete(movieManaged)
                })
                try context.save()
                
            } catch {
                assertionFailure("Error removing media item with id \(favoriteId)")
            }
        default:
            assertionFailure("Error removing media items")
        }
    }
    
}
