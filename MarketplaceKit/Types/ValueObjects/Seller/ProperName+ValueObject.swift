//
//  ProperName+ValueObject.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/10/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import FlowKit

public struct ProperName: CustomStringConvertible {
    
    public var description: String {
        return firstName + " " + lastName
    }
    
    public let firstName: String
    public let lastName:  String
    public init(firstName: String, lastName: String) throws {
        if case .invalid(let error) = ProperName.validateFirstName(firstName) {
            throw error
        }
        
        if case .invalid(let error) = ProperName.validateLastName(firstName) {
            throw error
        }
        
        self.firstName = firstName
        self.lastName = lastName
    }
    
    public static func validateFirstName(_ firstName: String) -> ValidationResult {
        if firstName.isEmpty {
            return .invalid(ValidationError.invalidFirstName)
        }
        
        return .valid
    }
    
    public static func validateLastName(_ lastName: String) -> ValidationResult {
        if lastName.isEmpty {
            return .invalid(ValidationError.invalidLastName)
        }
        
        return .valid
    }
    
}

