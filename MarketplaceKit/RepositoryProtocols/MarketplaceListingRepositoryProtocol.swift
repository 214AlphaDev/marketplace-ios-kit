//
//  MarketplaceListingRepositoryProtocol.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 5/9/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

public protocol MarketplaceListingRepositoryProtocol {
    
    /// Persists the marketplace listing in database. It handles both create new or modify existing listing.
    ///
    /// - Parameter listing: Marketplace listing to persist.
    /// - Throws: Database errors.
    func persist(_ listing: MarketplaceListing) throws
    
    /// Gets the marketplace listing from database.
    ///
    /// - Parameter id: Id of marketplace listing to get.
    /// - Returns: Marketplace listing or nil if no listing exists with specified id.
    /// - Throws: Database errors.
    func get(id: String) throws -> MarketplaceListing?
    
    /// Gets all marketplace listings from database
    ///
    /// - Returns: Array of marketplace listings.
    /// - Throws: Database errors.
    func getAll() throws -> [MarketplaceListing]
    
    /// Gets specific range of marketplace listings from database.
    ///
    /// - Parameters:
    ///   - fromId: Id of listing to start from or nil to start from the beginning.
    ///   - count: Number of marketplace listings to get.
    /// - Returns: Array of marketplace listings.
    /// - Throws: Database errors.
    func get(fromId: String?, count: Int) throws -> [MarketplaceListing]
    
}
