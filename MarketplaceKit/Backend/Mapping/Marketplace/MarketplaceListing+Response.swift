//
//  MarketplaceListing+Response.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

extension MarketplaceListing {
    
    init(output: API.MarketplaceListingsQuery.Data.Listing) throws {
        guard let listedAt = TimeConverter.convertToDate(timeString: output.listedAt) else {
            throw ValidationError.invalidListingDate
        }
        
        self.init(
            id: output.id,
            name: output.name,
            description: output.description,
            photo: try ListingPhoto(output.photo),
            price: try Price(output: output.price),
            listedAt: listedAt,
            sellerId: try UUIDV4(output.seller.id)
        )
    }
    
    init(output: API.CreateMarketplaceListingMutation.Data.ListNewListing.Listing) throws {
        guard let listedAt = TimeConverter.convertToDate(timeString: output.listedAt) else {
            throw ValidationError.invalidListingDate
        }
        
        self.init(
            id: output.id,
            name: output.name,
            description: output.description,
            photo: try ListingPhoto(output.photo),
            price: try Price(output: output.price),
            listedAt: listedAt,
            sellerId: try UUIDV4(output.seller.id)
        )
    }
    
    init(output: API.EditMarketplaceListingMutation.Data.UpdateListing.Listing) throws {
        guard let listedAt = TimeConverter.convertToDate(timeString: output.listedAt) else {
            throw ValidationError.invalidListingDate
        }
        
        self.init(
            id: output.id,
            name: output.name,
            description: output.description,
            photo: try ListingPhoto(output.photo),
            price: try Price(output: output.price),
            listedAt: listedAt,
            sellerId: try UUIDV4(output.seller.id)
        )
    }
    
}
