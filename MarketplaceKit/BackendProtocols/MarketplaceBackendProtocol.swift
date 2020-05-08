//
//  MarketplaceBackendProtocol.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

public protocol MarketplaceBackendProtocol {
    
    /// Requests marketplace listings from backend.
    ///
    /// - Parameters:
    ///   - id: Id of listing to start from or nil to start from the beginning.
    ///   - count: Number of listings to get.
    ///   - callback: Callback when request is done with array of marketplace listings and sellers or error.
    func marketplaceListings(from id: String?, count: Int, callback: @escaping (Response<[(MarketplaceListing, Seller)]>) -> Void)
    
    /// Requests marketplace listing creation.
    ///
    /// - Parameters:
    ///   - creatingListing: Information needed to create the marketplace listing.
    ///   - callback: Callback when request is done with marketplace listing and seller or error.
    func createMarketplaceListing(_ creatingListing: CreatingMarketplaceListing, callback: @escaping (Response<(MarketplaceListing, Seller)>) -> Void)
    
    /// Requests marketplace listing modification.
    ///
    /// - Parameters:
    ///   - id: Id of listing to modify.
    ///   - modifiedListing: Modified listing data.
    ///   - callback: Callback with updated listing and seller or error.
    func editMarketplaceListing(id: String, modifiedListing: CreatingMarketplaceListing, callback: @escaping (Response<(MarketplaceListing, Seller)>) -> Void)
    
}
