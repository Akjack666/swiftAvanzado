//
//  Game.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 2/28/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

struct Game: MediaItemProvidable, MediaItemDetailedProvidable {

    let mediaItemId: String = "1245"
    let title: String = "A game"
    let imageURL: URL? = nil
    let creatorName: String? = nil
    let rating: Float? = nil
    let numberOfReviews: Int? = nil
    let creationDate: Date? = nil
    let price: Float? = nil
    let movieDescription: String? = nil

}
