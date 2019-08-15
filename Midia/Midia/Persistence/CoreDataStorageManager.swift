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
        let fetchRequest: NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
        let dateSortDescriptor: NSSortDescriptor = NSSortDescriptor(key: "releaseDate", ascending: true)
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
        let fetchRequest: NSFetchRequest<MovieManaged> = MovieManaged.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "movieId = %@", favoriteId)
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
        if let movie = favorite as? Movies {
            let movieManaged = MovieManaged(context: context)
            movieManaged.movieId = Int32(movie.movieId)
            movieManaged.title = movie.title
            movieManaged.releaseDate = movie.releaseDate
            movieManaged.coverURL = movie.coverURL?.absoluteString
            movieManaged.movieDescription = movie.movieDescription
            if let price = movie.price {
                movieManaged.price = price
            }
            
        
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
    }

}
