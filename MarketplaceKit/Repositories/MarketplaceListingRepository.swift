//
//  MarketplaceListingRepository.swift
//  MarketplaceKit
//
//  Created by Florian on 13.05.19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import RealmSwift

class MarketplaceListingModel : Object {
    
    @objc dynamic var id : String = ""
    @objc dynamic var desc : String = ""
    @objc dynamic var name : String = ""
    @objc dynamic var photoString : String = ""
    @objc dynamic var priceCurrency: String = ""
    @objc dynamic var priceAmount: String = ""
    @objc dynamic var listedAt: Date = Date()
    @objc dynamic var sellerId: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

func mapMarketplaceListingModelToEntity(listing: MarketplaceListingModel) throws -> MarketplaceListing {
    return MarketplaceListing(
        id: listing.id,
        name: listing.name,
        description: listing.desc,
        photo: try ListingPhoto(listing.photoString),
        price: try Price(amount: try PriceAmount(listing.priceAmount), currency: try Currency(code: listing.priceCurrency)),
        listedAt: listing.listedAt,
        sellerId: try UUIDV4(listing.sellerId)
    )
}

public class MarketplaceListingRepository: MarketplaceListingRepositoryProtocol {
    
    let db : Realm
    
    public init(db: Realm) {
        self.db = db
    }
    
    public func persist(_ listing: MarketplaceListing) throws {
        
        // map entity to model
        let model = MarketplaceListingModel()
        model.id = listing.id
        model.desc = listing.description
        model.name = listing.name
        model.photoString = listing.photo.pictureDataString
        model.priceAmount = listing.price.amount.description
        model.priceCurrency = listing.price.currency.code
        model.listedAt = listing.listedAt
        model.sellerId = listing.sellerId.description
        
        // persist model
        try self.db.write {
            self.db.add(model, update: true)
        }
    }
    
    public func get(id: String) throws -> MarketplaceListing? {
        guard let listing = db.object(ofType: MarketplaceListingModel.self, forPrimaryKey: id) else {
            return nil
        }
        
        return try mapMarketplaceListingModelToEntity(listing: listing)
    }
    
    public func getAll() throws -> [MarketplaceListing] {
        let models = self.db.objects(MarketplaceListingModel.self)
        
        return try models.map(mapMarketplaceListingModelToEntity)
    }
    
    public func get(fromId: String?, count: Int) throws -> [MarketplaceListing] {
        // TODO: Implement correct logic. It ignores the fromId parameter for now.
        
        let models = self.db.objects(MarketplaceListingModel.self)
        let countToGet = min(models.count, count)
        
        var entities = [MarketplaceListing]()
        for i in 0..<countToGet {
            entities.append(try mapMarketplaceListingModelToEntity(listing: models[i]))
        }
        
        return entities
    }
    
}
