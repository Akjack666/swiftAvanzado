//
//  MovieCollection.swift
//  Midia
//
//  Created by Dani rica on 15/07/2019.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation


struct MovieCollection {
    
   // let kind: String
    let resultCount: Int
    let results: [Movies]?
    
}

extension MovieCollection: Decodable {
    
    
}
