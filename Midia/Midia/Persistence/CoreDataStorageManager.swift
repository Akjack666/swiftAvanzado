//
//  CoreDataStorageManager.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/12/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation
import CoreData

// TODO: capa de abstraction para usar siempre media items

class CoreDataStorageManager: FavoritesProvidable {

    let mediaItemKind: MediaItemKind
    let stack = CoreDataStack.sharedInstance

    init(withMediaItemKind mediaItemKind: MediaItemKind) {
        self.mediaItemKind = mediaItemKind
    }

    func getFavorites() -> [MediaItemDetailedProvidable]? {
        let context = stack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
        let dateSortDescriptor: NSSortDescriptor = NSSortDescriptor(key: "publishedDate", ascending: true)
        let priceSortDescriptor = NSSortDescriptor(key: "price", ascending: false)
        fetchRequest.sortDescriptors = [dateSortDescriptor, priceSortDescriptor]
        do {
            let favorites = try context.fetch(fetchRequest)
            return favorites.map({ $0.mappedObject() })
        } catch {
            assertionFailure("Error fetching media items")
            return nil
        }
    }

    func getFavorite(byId favoriteId: String) -> MediaItemDetailedProvidable? {
        let context = stack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<BookManaged> = BookManaged.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "bookId = %@", favoriteId)
        fetchRequest.predicate = predicate
        do {
            let favorites = try context.fetch(fetchRequest)
            return favorites.last?.mappedObject()
        } catch {
            assertionFailure("Error fetching media item by id \(favoriteId)")
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
            bookManaged.bookDescription = book.movieDescription
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
        } else {
            fatalError("not supported yet :(")
        }

    }

    func remove(favoriteWithId favoriteId: String) {
        let context = stack.persistentContainer.viewContext
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
    }

}
