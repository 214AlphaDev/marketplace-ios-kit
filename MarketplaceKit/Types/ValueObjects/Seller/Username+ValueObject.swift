//
//  username+ValueObject.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/10/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public struct Username: CustomStringConvertible {
    
    public let username: String
    
    public var description: String {
        return username
    }
    
    public init(_ username: String) throws {
        if case .invalid(let error) = Username.validateUsername(username) {
            throw error
        }
        
        self.username = username
    }
    
    public static func validateUsername(_ username: String) -> ValidationResult {
        let usernameRegEx = "[a-z0-9_]+"
        let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernameRegEx)
        if !usernameTest.evaluate(with: username) {
            return .invalid(ValidationError.invalidUsername)
        }
        
        return .valid
    }
    
}
