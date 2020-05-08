//
//  Price+Response.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/7/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

extension Price {
    
    init(output: API.MarketplaceListingsQuery.Data.Listing.Price) throws {
        try self.init(
            amount: try PriceAmount(output.amount),
            currency: try Currency(output.currency)
        )
    }
    
    init(output: API.CreateMarketplaceListingMutation.Data.ListNewListing.Listing.Price) throws {
        try self.init(
            amount: try PriceAmount(output.amount),
            currency: try Currency(output.currency)
        )
    }
    
    init(output: API.EditMarketplaceListingMutation.Data.UpdateListing.Listing.Price) throws {
        try self.init(
            amount: try PriceAmount(output.amount),
            currency: try Currency(output.currency)
        )
    }
    
}
