//
//  UUIDV4+ValueObject.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public struct UUIDV4 : CustomStringConvertible {
    
    public let id: String
    
    public var description: String {
        return id
    }
    
    public init(_ id: String) throws {
        if case .invalid(let error) = UUIDV4.validateID(id) {
            throw error
        }
        
        self.id = id
    }
    
    public static func validateID(_ id: String) -> ValidationResult {
        let regEx = "^[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}$"
        let test = NSPredicate(format: "SELF MATCHES [c] %@", regEx)
        if !test.evaluate(with: id) {
            return .invalid(ValidationError.invalidUUIDV4String)
        }
        
        return .valid
    }
    
}
