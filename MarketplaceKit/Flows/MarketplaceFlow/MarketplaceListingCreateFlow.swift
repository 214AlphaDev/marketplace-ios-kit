//
//  MarketplaceListingCreateFlow.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol MarketplaceListingCreateFlowProtocol: Flow {}

public struct MarketplaceListingCreateFlowFactory {
    
    public static func build(marketplaceListingCreatePresenter: MarketplaceListingCreatePresenterProtocol) -> MarketplaceListingCreateFlowProtocol {
        
        return MarketplaceListingCreateFlow(marketplaceListingCreatePresenter: marketplaceListingCreatePresenter)
    }
    
}

class MarketplaceListingCreateFlow: SingleScreenFlow, MarketplaceListingCreateFlowProtocol, MarketplaceListingCreatePresenterDelegate {
    
    init(marketplaceListingCreatePresenter: MarketplaceListingCreatePresenterProtocol) {
        super.init(presenter: marketplaceListingCreatePresenter)
        
        marketplaceListingCreatePresenter.delegate = WeakWrapper(self)
    }
    
    // MARK: MarketplaceListingCreatePresenterDelegate
    
    func presenterRequestNavigateToMarketplaceListScreen(_ presenter: MarketplaceListingCreatePresenterProtocol) throws {
        try handle(action: CloseMarketplaceListingCreateScreenAction())
    }
    
}
