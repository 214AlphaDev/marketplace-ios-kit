//
//  MarketplaceListing.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

/// Represents the listing in the marketplace.
public struct MarketplaceListing {
    
    public let id: String
    public let name: String
    public let description: String
    public let photo: ListingPhoto
    public let price: Price
    public let listedAt: Date
    public let sellerId: UUIDV4
    
    public init(id: String, name: String, description: String, photo: ListingPhoto, price: Price, listedAt: Date, sellerId: UUIDV4) {
        self.id = id
        self.name = name
        self.description = description
        self.photo = photo
        self.price = price
        self.listedAt = listedAt
        self.sellerId = sellerId
    }
    
}
