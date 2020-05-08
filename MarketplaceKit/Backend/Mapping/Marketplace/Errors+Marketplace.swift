//
//  Errors+Marketplace.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

extension ResponseError {
    
    init(listNewListingError: API.ListNewListingError) {
        switch listNewListingError {
        case .unauthenticated:
            self = .unauthenticated
        case .__unknown(_):
            self = .unknownError
        }
    }
    
    init(updateListingError: API.UpdateListingError) {
        switch updateListingError {
        case .unauthenticated:
            self = .unauthenticated
        case .listingDoesNotExist:
            self = .listingDoesNotExist
        case .unauthorized:
            self = .unauthorized
        case .__unknown(_):
            self = .unknownError
        }
    }
    
}
