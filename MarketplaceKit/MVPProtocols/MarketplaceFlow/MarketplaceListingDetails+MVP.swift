//
//  MarketplaceListingDetails+MVP.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 5/9/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol MarketplaceListingDetailsPresenterDelegate: class {
    
    func presenterRequestNavigateToMarketplaceListScreen(_ presenter: MarketplaceListingDetailsPresenterProtocol) throws
    func presenter(_ presenter: MarketplaceListingDetailsPresenterProtocol, requestsNavigateToMarketplaceListingEditScreenWith listing: MarketplaceListing) throws
    
}

public protocol MarketplaceListingDetailsPresenterProtocol: Presenter {
    
    var delegate: WeakWrapper<MarketplaceListingDetailsPresenterDelegate> { get set }
    var view: MarketplaceListingDetailsViewProtocol { get }
    
    func edit()
    func update(with listing: MarketplaceListing)
    
}

public protocol MarketplaceListingDetailsViewProtocol: class, ViewControllerProvider, ErrorDisplayable, LoadingIndicatorDisplayable {
    
    var presenter: WeakWrapper<MarketplaceListingDetailsPresenterProtocol> { get set }
    
    func displayMarketplaceListing(_ listing: MarketplaceListing, seller: Seller)
    func setEditAllowed(_ allowed: Bool)
    func setIsListedByCurrentMember(_ flag: Bool)

}
