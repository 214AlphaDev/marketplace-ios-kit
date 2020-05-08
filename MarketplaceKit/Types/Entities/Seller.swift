//
//  Seller.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/10/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

public struct Seller {
    
    public let id: UUIDV4
    public let properName: ProperName
    public let username: Username
    public let profilePicture: ProfilePicture?
    public let emailAddress: EmailAddress
    
    public init(id: UUIDV4, properName: ProperName, username: Username, profilePicture: ProfilePicture?, emailAddress: EmailAddress) {
        self.id = id
        self.properName = properName
        self.username = username
        self.profilePicture = profilePicture
        self.emailAddress = emailAddress
    }
    
}
