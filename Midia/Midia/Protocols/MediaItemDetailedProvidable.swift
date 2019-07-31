//
//  MediaItemDetailedProvidable.swift
//  Midia
//
//  Created by Julio Martínez Ballester on 3/5/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import Foundation

protocol MediaItemDetailedProvidable {

    var mediaItemId: String { get }
    var title: String { get }
    var imageURL: URL? { get }
    var creatorName: String? { get }
    var rating: Float? { get }
    var numberOfReviews: Int? { get }
    var creationDate: Date? { get }
    var price: Float? { get }
    var movieDescription: String? { get }

}
