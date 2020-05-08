//
//  ErrorDescription.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

public struct ErrorDescription {
    
    public static func describe(error: Error) -> String? {
        guard let marketplaceKitError = error as? MarketplaceKitError else {
            return nil
        }
        
        return marketplaceKitError.errorDescription
    }
    
}
