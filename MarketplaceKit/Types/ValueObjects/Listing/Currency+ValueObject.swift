//
//  Currency+ValueObject.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/7/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

public enum Currency: CustomStringConvertible {
    
    case usd
    
    public var description: String {
        return code
    }
    
    public var code: String {
        switch self {
        case .usd:
            return "USD"
        }
    }
    
    public var denominator: UInt64 {
        switch self {
        case .usd:
            return 100
        }
    }
    
    public init(code: String) throws {
        let occurence = Currency.codes.filter { _, value -> Bool in
            return value == code
        }.first
        
        if let currency = occurence?.key {
            self = currency
        } else {
            throw ValidationError.invalidCurrencyCode(code: code)
        }
    }
    
    public static let codes: [Currency: String] = [
        .usd: "USD"
    ]
    
}
