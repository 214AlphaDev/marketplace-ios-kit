//
//  MarketplaceListingEditFlow.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 5/27/19.
//  Copyright © 2019 214Alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol MarketplaceListingEditFlowProtocol: Flow {}

public struct MarketplaceListingEditFlowFactory {
    
    public static func build(
        marketplaceListingEditPresenterFactory: (MarketplaceListing) -> MarketplaceListingEditPresenterProtocol,
        listing: MarketplaceListing) -> MarketplaceListingEditFlowProtocol {
        return MarketplaceListingEditFlow(marketplaceListingEditPresenter: marketplaceListingEditPresenterFactory(listing))
    }

}

class MarketplaceListingEditFlow: SingleScreenFlow, MarketplaceListingEditFlowProtocol, MarketplaceListingEditPresenterDelegate {
    
    init(marketplaceListingEditPresenter: MarketplaceListingEditPresenterProtocol) {
        super.init(presenter: marketplaceListingEditPresenter)
        
        marketplaceListingEditPresenter.delegate = WeakWrapper(self)
    }
    
    // MARK: MarketplaceListingEditPresenterDelegate
    
    func presenter(_ presenter: MarketplaceListingEditPresenterProtocol, requestNavigateBackWith updatedListing: MarketplaceListing) throws {
        try handle(action: CloseMarketplaceListingEditScreenAction(updatedListing: updatedListing))
    }
    
}
