//
//  ITunesMoviesAPIConsumerAlamofire.swift
//  Midia
//
//  Created by Dani rica on 18/07/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

import Alamofire

class ITunesMoviesAPIConsumerAlamofire: MediaItemAPIConsumable {
    
    func getLatestMediaItems(onSuccess success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        
        Alamofire.request(ITunesMoviesAPIConstants.getAbsoluteURL(withQueryParams: ["top"])).responseData { (response) in
            
            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: value)
                    success(movieCollection.results ?? [])
                } catch {
                    failure(error) // Error parseando, lo enviamos para arriba
                }
            }
        }
        
    }
    
    func getMediaItems(withQueryParams queryParams: String, success: @escaping ([MediaItemProvidable]) -> Void, failure: @escaping (Error?) -> Void) {
        let paramsList = queryParams.components(separatedBy: " ")
        
        Alamofire.request(ITunesMoviesAPIConstants.getAbsoluteURL(withQueryParams: paramsList)).responseData { (response) in
            
            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(let value):
                do {
                    let decoder = JSONDecoder()
                    let movieCollection = try decoder.decode(MovieCollection.self, from: value)
                    success(movieCollection.results ?? [])
                } catch {
                    failure(error) // Error parseando, lo enviamos para arriba
                }
            }
        }
        
    }
    
    func getMediaItem(byId mediaItemId: String, success: @escaping (MediaItemDetailedProvidable) -> Void, failure: @escaping (Error?) -> Void) {
        
        Alamofire.request(ITunesMoviesAPIConstants.urlForMovie(withId: mediaItemId)).responseData { (response) in
            
            switch response.result {
            case .failure(let error):
                failure(error)
            case .success(_):
                if let data = response.data {
                    do {
                        let decoder = JSONDecoder()
                        let movieCollection = try decoder.decode(MovieCollection.self, from: data)
                        if let movie = movieCollection.results?.first {
                            success(movie)
                        } else {
                           // failure(ErrorITunes.notFound)
                        }
                    } catch {
                        failure(error) // Error parseando, lo enviamos directamente
                    }
                } else {
                    fatalError("Expected data on a success call retriving a book by id \(mediaItemId)")
                }
            }
            
        }
    }
    
}
