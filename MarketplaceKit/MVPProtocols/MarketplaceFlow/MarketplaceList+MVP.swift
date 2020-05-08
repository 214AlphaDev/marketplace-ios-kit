//
//  MarketplaceList+MVP.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 5/9/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol MarketplaceListPresenterDelegate: class {
    
    func presenter(_ presenter: MarketplaceListPresenterProtocol, requestNavigateToMarketplaceListingDetailsScreenWith listing: MarketplaceListing) throws
    func presenterRequestNavigateToCreateMarketplaceListingScreen(_ presenter: MarketplaceListPresenterProtocol) throws
    
}

public protocol MarketplaceListPresenterProtocol: Presenter {
    
    var delegate: WeakWrapper<MarketplaceListPresenterDelegate> { get set }
    var view: MarketplaceListViewProtocol { get }
    
    func openDetailsScreen(for listing: MarketplaceListing)
    func openCreateMarketplaceListingScreen()
    /// Initiates fetch of marketplace listings from backend
    ///
    /// - Parameter callback: Callback that is called when fetch request is done, regardless of whether it was successful
    func fetchMarketplaceListings(callback: @escaping () -> Void)
    /// Reloads marketplace listings available on database
    func reloadMarketplaceListings()
    
}

public protocol MarketplaceListViewProtocol: class, ViewControllerProvider, ErrorDisplayable, LoadingIndicatorDisplayable {
    
    var presenter: WeakWrapper<MarketplaceListPresenterProtocol> { get set }
    
    func showMarketplaceListings(_ listings: [MarketplaceListing])
    
}
