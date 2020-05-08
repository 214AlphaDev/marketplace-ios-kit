//
//  CreatingMarketplaceListing.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

/// Represents listing of marketplace that is in a process of creation.
public struct CreatingMarketplaceListing {
    
    public var name: String
    public var description: String
    public var photo: ListingPhoto?
    public var price: Price?
    
    public init(name: String, description: String, photo: ListingPhoto?, price: Price?) {
        self.name = name
        self.description = description
        self.photo = photo
        self.price = price
    }
    
    public init() {
        self.init(name: "", description: "", photo: nil, price: nil)
    }
    
    public init(marketplaceListing: MarketplaceListing) {
        self.name = marketplaceListing.name
        self.description = marketplaceListing.description
        self.photo = marketplaceListing.photo
        self.price = marketplaceListing.price
    }
    
}
