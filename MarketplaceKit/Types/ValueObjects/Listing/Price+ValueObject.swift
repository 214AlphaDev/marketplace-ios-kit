//
//  Price+ValueObject.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/7/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

public struct Price: CustomStringConvertible {
    
    private static let formatter = { () -> NumberFormatter in
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter
    }()
    
    private static let floatNumberFormatter = { () -> NumberFormatter in
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        formatter.generatesDecimalNumbers = true
        formatter.numberStyle = .decimal
        
        return formatter
    }()
    
    public let amount: PriceAmount
    public let currency: Currency
    
    public var description: String {
        Price.formatter.currencyCode = currency.code
        let value = NSDecimalNumber(value: amount.value).dividing(by: NSDecimalNumber(value: currency.denominator))
        return Price.formatter.string(from: value) ?? "?"
    }
    
    public var amountDesription: String {
        let value = NSDecimalNumber(value: amount.value).dividing(by: NSDecimalNumber(value: currency.denominator))
        return Price.floatNumberFormatter.string(from: value) ?? "?"
    }
    
    public init(amount: PriceAmount, currency: Currency) throws {
        self.amount = amount
        self.currency = currency
    }
    
    static public func convertDecimalAmountString(_ amountString: String, for currency: Currency) -> PriceAmount? {
        guard var number = floatNumberFormatter.number(from: amountString) as? NSDecimalNumber else {
            return nil
        }
        
        number = number.multiplying(by: NSDecimalNumber(value: currency.denominator))
        let rounded = number.rounding(accordingToBehavior: NSDecimalNumberHandler(roundingMode: .plain, scale: 0, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false))
        
        if !rounded.isEqual(to: number) {
            // Number has too much digits after decimal point
            return nil
        }
        
        return try? PriceAmount(rounded.stringValue)
    }
    
}
