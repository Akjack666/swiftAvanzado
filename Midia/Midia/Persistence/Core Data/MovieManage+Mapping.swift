//
//  MovieManage+Mapping.swift
//  Midia
//
//  Created by Dani rica on 31/07/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation


extension MovieManaged {
    
    func mappedObject() -> Movies {
        
        
        let url: URL? = coverURL != nil ? URL(string: coverURL!) : nil
        
        return Movies(movieId: Int(movieId), title: title!, artistName: artistName, releaseDate: releaseDate, description: movieDescription, coverURL: url, duration: Int(duration), genre: genre, price: price)
    }
    
}
