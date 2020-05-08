//
//  Actions.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 5/26/19.
//  Copyright © 2019 214Alpha. All rights reserved.
//

import Foundation
import FlowKit

class DisplayMarketplaceListingDetailsScreenAction: Action {
    let listing: MarketplaceListing
    
    init(listing: MarketplaceListing) {
        self.listing = listing
    }
}
class CloseMarketplaceListingDetailsScreenAction: Action {}

class DisplayMarketplaceListingCreateScreenAction: Action {}
class DisplayMarketplaceListingEditScreenAction: Action {
    let listing: MarketplaceListing
    
    init(listing: MarketplaceListing) {
        self.listing = listing
    }
}

class CloseMarketplaceListingCreateScreenAction: Action {}
class CloseMarketplaceListingEditScreenAction: Action {
    let updatedListing: MarketplaceListing
    
    init(updatedListing: MarketplaceListing) {
        self.updatedListing = updatedListing
    }
}
