//
//  MarketplaceService.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

public class MarketplaceService: MarketplaceServiceProtocol {
    
    let marketplaceListingRepository: MarketplaceListingRepositoryProtocol
    let sellerRepository: SellerRepositoryProtocol
    let marketplaceBackend: MarketplaceBackendProtocol
    
    public init(marketplaceBackend: MarketplaceBackendProtocol,
                marketplaceListingRepository: MarketplaceListingRepositoryProtocol,
                sellerRepository: SellerRepositoryProtocol) {
        self.marketplaceBackend = marketplaceBackend
        self.marketplaceListingRepository = marketplaceListingRepository
        self.sellerRepository = sellerRepository
    }
    
    public func getSeller(id: UUIDV4) throws -> Seller? {
        return try sellerRepository.get(id: id)
    }
    
    public func getMarketplaceListing(id: String) throws -> MarketplaceListing? {
        return try marketplaceListingRepository.get(id: id)
    }
    
    public func getAllMarketplaceListings() throws -> [MarketplaceListing] {
        return sortListings(try marketplaceListingRepository.getAll())
    }
    
    public func getMarketplaceListings(fromId: String?, count: Int) throws -> [MarketplaceListing] {
        return sortListings(try marketplaceListingRepository.get(fromId: fromId, count: count))
    }
    
    public func fetchMarketplaceListings(fromId: String?, count: Int, callback: @escaping (Response<[MarketplaceListing]>) -> Void) {
        marketplaceBackend.marketplaceListings(from: fromId, count: count) { [weak self] response in
            guard let self = self else {
                callback(.failure(ResponseError.unknownError))
                return
            }
            
            switch response {
                
            case .success(let listingsAndSellers):
                do {
                    try listingsAndSellers.forEach { data in
                        try self.saveMarketplaceListingAndSeller(data)
                    }
                    callback(.success(self.sortListings(listingsAndSellers.map { $0.0 } )))
                } catch {
                    callback(.failure(PersistenceError.marketplaceListingPersistenceFailed(underlyingError: error)))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    public func createMarketplaceListing(_ creatingListing: CreatingMarketplaceListing, callback: @escaping (Response<MarketplaceListing>) -> Void) {
        marketplaceBackend.createMarketplaceListing(creatingListing) { [weak self] response in
            switch response {
                
            case .success(let data):
                do {
                    try self?.saveMarketplaceListingAndSeller(data)
                    callback(.success(data.0))
                } catch {
                    callback(.failure(PersistenceError.marketplaceListingPersistenceFailed(underlyingError: error)))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    public func editMarketplaceListing(with id: String, modifiedListing: CreatingMarketplaceListing, callback: @escaping (Response<MarketplaceListing>) -> Void) {
        marketplaceBackend.editMarketplaceListing(id: id, modifiedListing: modifiedListing) { [weak self] response in
            switch response {
                
            case .success(let data):
                do {
                    try self?.saveMarketplaceListingAndSeller(data)
                    callback(.success(data.0))
                } catch {
                    callback(.failure(PersistenceError.marketplaceListingPersistenceFailed(underlyingError: error)))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    func saveMarketplaceListingAndSeller(_ data: (listing: MarketplaceListing, seller: Seller)) throws {
        try marketplaceListingRepository.persist(data.listing)
        try sellerRepository.persist(data.seller)
    }
    
    func sortListings(_ listings: [MarketplaceListing]) -> [MarketplaceListing] {
        return listings.sorted { lhs, rhs in
            lhs.listedAt.compare(rhs.listedAt) == .orderedAscending
        }
    }
    
}
