//
//  MarketplaceBackend.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import Apollo

public class MarketplaceBackend: MarketplaceBackendProtocol {
    
    var apollo: ApolloClient
    
    public init(url: URL, rawAccessToken: String) {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Authorization-Bearer": rawAccessToken]
        self.apollo = ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
    }
    
    public func marketplaceListings(from id: String?, count: Int, callback: @escaping (Response<[(MarketplaceListing, Seller)]>) -> Void) {
        apollo.fetch(query: API.MarketplaceListingsQuery(fromId: id, count: count), cachePolicy: .fetchIgnoringCacheData) { result, error in
            if let error = error {
                callback(.failure(ResponseError.requestFailed(serverErrorMessage:  error.localizedDescription)))
                return
            }
            
            guard let response = result?.data?.listings else {
                callback(.failure(ResponseError.missingResponseAndError))
                return
            }
            
            do {
                let listings = try response.map {
                    (try MarketplaceListing(output: $0), try Seller(output: $0.seller))
                }
                callback(.success(listings))
            } catch {
                callback(.failure(error))
            }
        }
    }
    
    public func createMarketplaceListing(_ creatingListing: CreatingMarketplaceListing, callback: @escaping (Response<(MarketplaceListing, Seller)>) -> Void) {
        guard let photo = creatingListing.photo else {
            callback(.failure(ValidationError.invalidListingPhoto))
            return
        }
        
        guard let price = creatingListing.price else {
            callback(.failure(ValidationError.invalidListingPrice))
            return
        }
        
        apollo.perform(mutation: API.CreateMarketplaceListingMutation(
            name: creatingListing.name,
            description: creatingListing.description,
            photo: photo.pictureDataString,
            priceCurrency: .init(price.currency),
            priceAmount: price.amount.description)) { result, error in
            if let error = error {
                callback(.failure(ResponseError.requestFailed(serverErrorMessage:  error.localizedDescription)))
                return
            }
            
            guard let response = result?.data?.listNewListing else {
                callback(.failure(ResponseError.missingResponseAndError))
                return
            }
            
            if let error = response.error {
                callback(.failure(ResponseError(listNewListingError: error)))
                return
            }
            
            guard let output = response.listing else {
                callback(.failure(ResponseError.missingResponseAndError))
                return
            }
            
            do {
                callback(.success((
                    try MarketplaceListing(output: output),
                    try Seller(output: output.seller)
                )))
            } catch {
                callback(.failure(error))
            }
        }
    }
    
    public func editMarketplaceListing(id: String, modifiedListing: CreatingMarketplaceListing, callback: @escaping (Response<(MarketplaceListing, Seller)>) -> Void) {
        guard let photo = modifiedListing.photo else {
            callback(.failure(ValidationError.invalidListingPhoto))
            return
        }
        guard let price = modifiedListing.price else {
            callback(.failure(ValidationError.invalidListingPrice))
            return
        }
        
        apollo.perform(mutation: API.EditMarketplaceListingMutation(
            id: id,
            name: modifiedListing.name,
            description: modifiedListing.description,
            photo: photo.pictureDataString,
            priceCurrency: .init(price.currency),
            priceAmount: price.amount.description)) { result, error in
            if let error = error {
                callback(.failure(ResponseError.requestFailed(serverErrorMessage:  error.localizedDescription)))
                return
            }
            
            guard let response = result?.data?.updateListing else {
                callback(.failure(ResponseError.missingResponseAndError))
                return
            }
            
            if let error = response.error {
                callback(.failure(ResponseError(updateListingError: error)))
                return
            }
            
            guard let output = response.listing else {
                callback(.failure(ResponseError.missingResponseAndError))
                return
            }
            
            do {
                callback(.success((
                    try MarketplaceListing(output: output),
                    try Seller(output: output.seller)
                )))
            } catch {
                callback(.failure(error))
            }
        }
    }
    
}

