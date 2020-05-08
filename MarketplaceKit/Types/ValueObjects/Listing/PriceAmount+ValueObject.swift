//
//  PriceAmount+ValueObject.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/7/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public struct PriceAmount: CustomStringConvertible {
    
    private static let formatter = { () -> NumberFormatter in
        let formatter = NumberFormatter()
        formatter.allowsFloats = false
        formatter.generatesDecimalNumbers = true
        
        return formatter
    }()
    
    public let value: UInt64
    
    public var description: String {
        return String(describing: value)
    }
    
    public init(_ amountString: String) throws {
        guard let amount = PriceAmount.convertAmountString(amountString) else {
            throw ValidationError.invalidPriceAmount
        }
        if case .invalid(let error) = PriceAmount.validateAmount(amount) {
            throw error
        }
        
        self.value = amount
    }
    
    public static func convertAmountString(_ amountString: String) -> UInt64? {
        return PriceAmount.formatter.number(from: amountString)?.uint64Value
    }
    
    public static func validateAmount(_ amount: UInt64) -> ValidationResult {
        return .valid
    }
    
    public static func validateAmountString(_ amountString: String) -> ValidationResult {
        if PriceAmount.convertAmountString(amountString) != nil {
            return .valid
        } else {
            return .invalid(ValidationError.invalidPriceAmount)
        }
    }
    
}
