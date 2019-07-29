//
//  Constants.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/4/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

struct GoogleBooksAPIConstants {

    private static let apiKey = "AIzaSyBUUhlpyxGklV31hSETfN5bVaNgtnsgFfU"

    static func getAbsoluteURL(withQueryParams queryParams: [String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes"
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]
        components.queryItems?.append(URLQueryItem(name: "q", value: queryParams.joined(separator: "+")))

        return components.url!
    }

    static func urlForBook(withId bookId: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.googleapis.com"
        components.path = "/books/v1/volumes/\(bookId)"
        components.queryItems = [URLQueryItem(name: "key", value: apiKey)]

        return components.url!
    }

}


struct ITunesMoviesAPIConstants {
    
    
    static func getAbsoluteURL(withQueryParams queryParams: [String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        
    
        components.queryItems = [URLQueryItem(name: "media", value: "movie"),
                                 URLQueryItem(name: "attribute", value: "movieTerm"),
            URLQueryItem(name: "country", value: "es")
        ]
        components.queryItems?.append(URLQueryItem(name: "term", value: queryParams.joined(separator: "+")))
        return components.url!
    }
    
    
    
    
    static func urlForMovie(withId movieId: String) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/lookup"
        components.queryItems = [URLQueryItem(name: "country", value: "es"),URLQueryItem(name: "id", value: movieId)]
        print(components.url!)
        return components.url!
    }
    
}

