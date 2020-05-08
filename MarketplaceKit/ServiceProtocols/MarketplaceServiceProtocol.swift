//
//  MarketplaceServiceProtocol.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 5/9/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

public protocol MarketplaceServiceProtocol {
    
    /// Gets the marketplace listing from database.
    ///
    /// - Parameter id: Id of the listing to get.
    /// - Returns: Returns a marketplace listing or nil if this listing doesn't exist in database.
    /// - Throws: Database errors.
    func getMarketplaceListing(id: String) throws -> MarketplaceListing?
    
    /// Gets all marketplace listings from the database.
    ///
    /// - Returns: Array of all marketplace listings in database.
    /// - Throws: Database errors.
    func getAllMarketplaceListings() throws -> [MarketplaceListing]
    
    /// Gets specific number of marketplace listings from database starting with specified id.
    ///
    /// - Parameters:
    ///   - fromId: Id of listing to start from or nil to start from the beginning.
    ///   - count: Number of listings to get.
    /// - Returns: A list of marketplace listings.
    /// - Throws: Database errors.
    func getMarketplaceListings(fromId: String?, count: Int) throws -> [MarketplaceListing]
    
    /// Fetches marketplace listings from backend.
    ///
    /// - Parameters:
    ///   - fromId: Id of listing to start from or nil to start from the beginning.
    ///   - count: Number of listings to fetch.
    ///   - callback: Called when request is done with marketplace listings array.
    func fetchMarketplaceListings(fromId: String?, count: Int, callback: @escaping (Response<[MarketplaceListing]>) -> Void)
    
    /// Sends the request to create new marketplace listing.
    ///
    /// - Parameters:
    ///   - creatingListing: Information needed to create the marketplace listing.
    ///   - callback: Callback with marketplace listing on success and error on fail.
    func createMarketplaceListing(_ creatingListing: CreatingMarketplaceListing, callback:  @escaping (Response<MarketplaceListing>) -> Void)
    
    /// Sends the request to modify existing marketplace listing.
    ///
    /// - Parameters:
    ///   - id: Id of marketplace listing to modify
    ///   - modifiedListing: Struct with updated marketplace listing information
    ///   - callback: Callback with marketplace listing on success and error on fail.
    func editMarketplaceListing(with id: String, modifiedListing: CreatingMarketplaceListing, callback:  @escaping (Response<MarketplaceListing>) -> Void)
    
    /// Gets seller from database.
    ///
    /// - Parameter id: Id of seller to get.
    /// - Returns: Returns a seller or nil if this seller doesn't exist in database.
    /// - Throws: Database errors.
    func getSeller(id: UUIDV4) throws -> Seller?
    
}
