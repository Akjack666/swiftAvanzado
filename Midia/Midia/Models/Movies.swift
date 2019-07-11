//
//  Movies.swift
//  Midia
//
//  Created by Dani rica on 11/07/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation


struct Movie {
    
    let movieId: String
    let title: String
    let artistName: String?
    let releaseDate: Date?
    let description: String?
    let coverURL: URL?
    let duration: Int?
    let genre: String?
    let price: Float?
    
    
    init(movieId : String,title: String, artistName: String? = nil, releaseDate: Date? = nil, description : String? = nil, coverURL : URL? = nil, duration: Int? = nil, genre : String? = nil, price: Float? = nil) {
        
        self.movieId = movieId
        self.title = title
        self.artistName = artistName
        self.releaseDate = releaseDate
        self.description = description
        self.coverURL = coverURL
        self.duration = duration
        self.genre = genre
        self.price = price
    }
    
    
    
}

extension Movie: Codable {
    
    enum CodingKeys: String, CodingKey {
        case movieId = "id"
        case title = "trackId"
        case artistName
        case releaseDate
        case description = "longDescription"
        case coverURL = "artworkUrl100"
        case duration = "trackTimeMillis"
        case genre = "primaryGenreName"
        case price = "trackPrice"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        movieId = try container.decode(String.self, forKey: .movieId)
        title = try container.decode(String.self, forKey: .title)
        artistName = try container.decodeIfPresent(String.self, forKey: .artistName)
        
        if let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate) {
            releaseDate = DateFormatter.booksAPIDateFormatter.date(from: releaseDateString)
        } else {
            releaseDate = nil
        }
        description = try container.decodeIfPresent(String.self, forKey: .description)
        coverURL = try container.decodeIfPresent(URL.self, forKey: .coverURL)
        duration = try container.decodeIfPresent(Int.self, forKey: .duration)
        genre = try container.decodeIfPresent(String.self, forKey: .genre)
        price = try container.decodeIfPresent(Float.self, forKey: .price)
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(movieId, forKey: .movieId)
        try container.encode(title, forKey: .title)
        try container.encodeIfPresent(artistName, forKey: .artistName)
        if let date = releaseDate {
            try container.encode(DateFormatter.booksAPIDateFormatter.string(from: date), forKey: .releaseDate)
        }
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(coverURL, forKey: .coverURL)
        try container.encodeIfPresent(duration, forKey: .duration)
        try container.encodeIfPresent(genre, forKey: .genre)
        try container.encodeIfPresent(price, forKey: .price)
    }
    
}


extension Movie: MediaItemProvidable {
    
    var mediaItemId: String {
        return movieId
    }
    
    var imageURL: URL? {
        return coverURL
    }
    
}
