//
//  Currency+Response.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/7/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

extension Currency {
    
    init(_ currency: API.Currency) throws {
        switch currency {
        case .usd:
            self = .usd
        case .__unknown(let rawValue):
            throw ValidationError.invalidCurrencyEnumValue(rawValue)
        }
    }
    
}

extension API.Currency {
    
    init(_ currency: Currency) {
        switch currency {
        case .usd:
            self = .usd
        }
    }
    
}
