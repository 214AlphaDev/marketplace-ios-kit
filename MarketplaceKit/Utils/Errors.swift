//
//  Errors.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

protocol MarketplaceKitError: Error {
    var errorDescription: String { get }
}

enum ValidationError: MarketplaceKitError {
    case invalidUUIDV4String
    case invalidListingPhoto
    case invalidListingPhotoPictureData
    case invalidTooSmallMarketplaceListingName
    case invalidTooSmallMarketplaceListingDescription
    case invalidPriceAmount
    case invalidCurrencyEnumValue(_ rawValue: String)
    case invalidCurrencyCode(code: String)
    case invalidListingPrice
    case invalidListingDate
    case invalidEmailAddress
    case invalidUsername
    case invalidProfilePicture
    case invalidProfilePictureData
    case invalidFirstName
    case invalidLastName
    
    var errorDescription: String {
        switch self {
        case .invalidUUIDV4String:
            return "Provided uuidv4 string is invalid"
        case .invalidListingPhoto:
            return "Provided picture is invalid"
        case .invalidListingPhotoPictureData:
            return "Provided picture data is invalid"
        case .invalidTooSmallMarketplaceListingName:
            return "Marketplace listing name should be at least 5 characters"
        case .invalidTooSmallMarketplaceListingDescription:
            return "Marketplace listing description should be at least 30 characters"
        case .invalidPriceAmount:
            return "Price amount string is incorrect"
        case .invalidCurrencyCode(let code):
            return "Currency code \(code) is incorrect"
        case .invalidCurrencyEnumValue(let rawValue):
            return "Currency enum value \(rawValue) is incorrect"
        case .invalidListingPrice:
            return "Marketplace listing price is incorrect"
        case .invalidListingDate:
            return "Marketplace listing date is incorrect"
        case .invalidEmailAddress:
            return "Provided email address is invalid"
        case .invalidUsername:
            return "Provided username is invalid"
        case .invalidProfilePicture:
            return "Provided picture is invalid"
        case .invalidProfilePictureData:
            return "Provided picture data is invalid"
        case .invalidFirstName:
            return "Provided first name is invalid"
        case .invalidLastName:
            return "Provided last name is invalid"
        }
    }
}

enum ConsistencyError: MarketplaceKitError {
    
    case noSellerFoundForMarketplaceListing(_ listing: MarketplaceListing)
    
    var errorDescription: String {
        switch self {
        case .noSellerFoundForMarketplaceListing(let listing):
            return "Listing with id \(listing.id) have seller with id \(listing.sellerId.id) which does not exist on database."
        }
    }
    
}

enum ResponseError: MarketplaceKitError {
    
    case requestFailed(serverErrorMessage: String)
    case missingResponseAndError
    case unknownError
    case unauthenticated
    case unauthorized
    case listingDoesNotExist
    
    var errorDescription: String {
        switch self {
        case .requestFailed(let message):
            return "Request failed with error message: \(message)"
        case .missingResponseAndError:
            return "Server responded without any response or error. Please report this issue"
        case .unknownError:
            return "Something went wrong"
        case .unauthenticated:
            return "Not authenticated"
        case .listingDoesNotExist:
            return "Requested listing does not exist"
        case .unauthorized:
            return "You're not authorized to do that"
        }
    }
    
}

enum PersistenceError: MarketplaceKitError {
    
    case marketplaceListingPersistenceFailed(underlyingError: Error)
    
    var errorDescription: String {
        switch self {
        case .marketplaceListingPersistenceFailed(let underlyingError):
            return "Failed to persist marketplace listing with underlying error \(ErrorDescription.describe(error: underlyingError) ?? underlyingError.localizedDescription)"
        }
    }
    
    
}
