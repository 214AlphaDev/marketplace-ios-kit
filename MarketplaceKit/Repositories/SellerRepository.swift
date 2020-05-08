//
//  SellerRepository.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/10/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import RealmSwift

class SellerModel : Object {
    @objc dynamic var id: String = ""
    @objc dynamic var emailAddress: String = ""
    @objc dynamic var profilePicture: String?
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var username: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

public class SellerRepository: SellerRepositoryProtocol {
    
    private let db : Realm
    
    // TODO: Decide how to pass db better
    public init(db: Realm) {
        self.db = db
    }
    
    public func persist(_ seller: Seller) throws {
        let sm = SellerModel()
        
        // map entity to persitance model
        sm.id = String(describing: seller.id)
        sm.emailAddress = String(describing: seller.emailAddress)
        sm.username = String(describing: seller.username)
        sm.firstName = seller.properName.firstName
        sm.lastName = seller.properName.lastName
        if let picture = seller.profilePicture {
            sm.profilePicture = picture.pictureDataString
        }
        
        // persist model
        try self.db.write {
            self.db.add(sm, update: true)
        }
        
    }
    
    public func get(id: UUIDV4) throws -> Seller? {
        
        // fetch the desired member by it's unique id
        let fetchedSeller = db.object(ofType: SellerModel.self, forPrimaryKey: id.description)
        
        // exit with nil in case member doesn't exist
        guard let seller = fetchedSeller else {
            return nil
        }
        
        // create profile picture
        let profilePicture : ProfilePicture?
        switch seller.profilePicture {
        case .some(let picture):
            profilePicture = try ProfilePicture(picture)
        case .none:
            profilePicture = nil
        }
        
        // construct seller model
        let s = Seller(
            id: try UUIDV4(seller.id),
            properName: try ProperName(firstName: seller.firstName, lastName: seller.lastName),
            username: try Username(seller.username),
            profilePicture: profilePicture,
            emailAddress: try EmailAddress(seller.emailAddress)
        )
        
        return s
        
    }
    
}
