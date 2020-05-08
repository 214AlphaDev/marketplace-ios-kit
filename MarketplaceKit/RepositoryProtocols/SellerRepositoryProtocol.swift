//
//  SellerRepositoryProtocol.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/10/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

public protocol SellerRepositoryProtocol {
    func persist(_ seller: Seller) throws
    func get(id: UUIDV4) throws -> Seller?
}
