//
//  MarketplaceKitDatabaseFactory.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import RealmSwift

public struct MarketplaceKitDatabaseFactory {
    
    // TODO: Figure out better to way to pass in the subject id.
    public static func buildDatabase(subjectId: String) throws -> Realm {
        let url = Realm.Configuration.defaultConfiguration.fileURL!.deletingLastPathComponent().appendingPathComponent("\(subjectId)_marketplacekit")
        
        return try Realm(fileURL: url)
    }
    
}
