//
//  MarketplaceListFlow.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol MarketplaceListFlowProtocol: Flow {}

public struct MarketplaceListFlowFactory {
    
    public static func build(
        navigationController: UINavigationController,
        marketplaceListPresenter: MarketplaceListPresenterProtocol,
        marketplaceListingDetailsFlowFactory: @escaping (MarketplaceListing) -> MarketplaceListingDetailsFlowProtocol,
        marketplaceListingCreateFlow: MarketplaceListingCreateFlowProtocol) -> MarketplaceListFlowProtocol {
        let builder = FlowBuilder(rootFlow: MarketplaceListFlow(navigationController: navigationController, marketplaceListPresenter: marketplaceListPresenter))
        
        return builder
            .push(on: DisplayMarketplaceListingDetailsScreenAction.self) { _, action in
                return marketplaceListingDetailsFlowFactory(action.listing)
            }
            .on(DisplayMarketplaceListingCreateScreenAction.self) { flow, _ in
                try flow.present(marketplaceListingCreateFlow, animated: true)
            }
            .on(CloseMarketplaceListingDetailsScreenAction.self) { root, _ in
                marketplaceListPresenter.reloadMarketplaceListings()
                root.popFlow(animated: true)
            }
            .on(CloseMarketplaceListingCreateScreenAction.self) { root, _ in
                marketplaceListPresenter.reloadMarketplaceListings()
                root.dismissPresenterFlow(animated: true)
            }
            .rootFlow
    }
    
}

public class MarketplaceListFlow: PushPopNavigationFlow, MarketplaceListFlowProtocol, MarketplaceListPresenterDelegate {
    
    init(navigationController: UINavigationController, marketplaceListPresenter: MarketplaceListPresenterProtocol) {
        super.init(navigationController: navigationController, rootFlow: SingleScreenFlow(presenter: marketplaceListPresenter))
        
        marketplaceListPresenter.delegate = WeakWrapper(self)
    }
    
    // MARK: MarketplaceListPresenterDelegate
    
    public func presenterRequestNavigateToCreateMarketplaceListingScreen(_ presenter: MarketplaceListPresenterProtocol) throws {
        try handle(action: DisplayMarketplaceListingCreateScreenAction())
    }
    
    public func presenter(_ presenter: MarketplaceListPresenterProtocol, requestNavigateToMarketplaceListingDetailsScreenWith listing: MarketplaceListing) throws {
        try handle(action: DisplayMarketplaceListingDetailsScreenAction(listing: listing))
    }
    
}
