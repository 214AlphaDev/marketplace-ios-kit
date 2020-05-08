//
//  MarketplaceListingDetailsFlow.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/7/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol MarketplaceListingDetailsFlowProtocol: Flow {}

public struct MarketplaceListingDetailsFlowFactory {
    
    public static func build(
        marketplaceListingDetailsPresenterFactory: (MarketplaceListing) -> MarketplaceListingDetailsPresenterProtocol,
        listing: MarketplaceListing,
        marketplaceListingEditFlowFactory: @escaping (MarketplaceListing) -> MarketplaceListingEditFlowProtocol) -> MarketplaceListingDetailsFlowProtocol {
        let builder = FlowBuilder(rootFlow: MarketplaceListingDetailsFlow(marketplaceListingDetailsPresenter: marketplaceListingDetailsPresenterFactory(listing)))
        
        return builder.on(DisplayMarketplaceListingEditScreenAction.self) { flow, action in
            try flow.present(marketplaceListingEditFlowFactory(action.listing), animated: true)
            }
            .on(CloseMarketplaceListingEditScreenAction.self) { flow, action in
                flow.presenter.update(with: action.updatedListing)
                flow.dismissPresenterFlow(animated: true)
        }.rootFlow
    }
    
}

public class MarketplaceListingDetailsFlow: SingleScreenFlow, MarketplaceListingDetailsFlowProtocol, MarketplaceListingDetailsPresenterDelegate {
    
    var presenter: MarketplaceListingDetailsPresenterProtocol {
        return basePresenter as! MarketplaceListingDetailsPresenterProtocol
    }
    
    init(marketplaceListingDetailsPresenter: MarketplaceListingDetailsPresenterProtocol) {
        super.init(presenter: marketplaceListingDetailsPresenter)
        
        marketplaceListingDetailsPresenter.delegate = WeakWrapper(self)
    }
    
    public func presenterRequestNavigateToMarketplaceListScreen(_ presenter: MarketplaceListingDetailsPresenterProtocol) throws {
        try handle(action: CloseMarketplaceListingDetailsScreenAction())
    }
    
    public func presenter(_ presenter: MarketplaceListingDetailsPresenterProtocol, requestsNavigateToMarketplaceListingEditScreenWith listing: MarketplaceListing) throws {
        try handle(action: DisplayMarketplaceListingEditScreenAction(listing: listing))
    }
    
}
