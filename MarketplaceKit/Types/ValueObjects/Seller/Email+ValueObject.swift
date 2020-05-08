//
//  Email+ValueObject.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/10/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public struct EmailAddress: CustomStringConvertible {
    
    public let emailAddress: String
    
    public var description: String {
        return emailAddress
    }
    
    public init(_ emailAddress: String) throws {
        if case .invalid(let error) = EmailAddress.validateEmailAddress(emailAddress) {
            throw error
        }
        
        self.emailAddress = emailAddress
    }
    
    public static func validateEmailAddress(_ emailAddress: String) -> ValidationResult {
        let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        if !emailTest.evaluate(with: emailAddress) {
            return .invalid(ValidationError.invalidEmailAddress)
        }
        
        return .valid
    }
}
