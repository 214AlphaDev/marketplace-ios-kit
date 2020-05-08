//
//  Seller+Response.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/10/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

extension Seller {
    
    init(output: API.MarketplaceListingsQuery.Data.Listing.Seller) throws {
        self.init(
            id: try UUIDV4(output.id),
            properName: try ProperName(
                firstName: output.firstName,
                lastName: output.lastName
            ),
            username: try Username(output.username),
            profilePicture: try ProfilePicture.from(dataString: output.profilePicture),
            emailAddress: try EmailAddress(output.emailAddress)
        )
    }
    
    init(output: API.CreateMarketplaceListingMutation.Data.ListNewListing.Listing.Seller) throws {
        self.init(
            id: try UUIDV4(output.id),
            properName: try ProperName(
                firstName: output.firstName,
                lastName: output.lastName
            ),
            username: try Username(output.username),
            profilePicture: try ProfilePicture.from(dataString: output.profilePicture),
            emailAddress: try EmailAddress(output.emailAddress)
        )
    }
    
    init(output: API.EditMarketplaceListingMutation.Data.UpdateListing.Listing.Seller) throws {
        self.init(
            id: try UUIDV4(output.id),
            properName: try ProperName(
                firstName: output.firstName,
                lastName: output.lastName
            ),
            username: try Username(output.username),
            profilePicture: try ProfilePicture.from(dataString: output.profilePicture),
            emailAddress: try EmailAddress(output.emailAddress)
        )
    }
    
}
