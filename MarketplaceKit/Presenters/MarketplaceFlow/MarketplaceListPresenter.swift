//
//  MarketplaceListPresenter.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit
import CommunityKit

public class MarketplaceListPresenter: MarketplaceListPresenterProtocol {
    
    public var delegate: WeakWrapper<MarketplaceListPresenterDelegate> = WeakWrapper()
    public let view: MarketplaceListViewProtocol
    private let marketplaceService: MarketplaceServiceProtocol
    
    public init(view: MarketplaceListViewProtocol, marketplaceService: MarketplaceServiceProtocol, memberService: MemberServiceProtocol) {
        self.view = view
        self.marketplaceService = marketplaceService
        view.presenter = WeakWrapper(self)
        
        displayMarketplaceListings()
    }
    
    public func openDetailsScreen(for listing: MarketplaceListing) {
        do {
            try delegate.wrapped?.presenter(self, requestNavigateToMarketplaceListingDetailsScreenWith: listing)
        } catch {
            view.displayError(title: "Error", error: error)
        }
    }
    
    public func openCreateMarketplaceListingScreen() {
        do {
            try delegate.wrapped?.presenterRequestNavigateToCreateMarketplaceListingScreen(self)
        } catch {
            view.displayError(title: "Error", error: error)
        }
    }
    
    public func fetchMarketplaceListings(callback: @escaping () -> Void) {
        // TODO: Implement paging
        view.setLoadingIndicatorVisible(true)
        marketplaceService.fetchMarketplaceListings(fromId: nil, count: 100) { [weak self] response in
            guard let self = self else {
                callback()
                return
            }
            
            switch response {
            case .failure(let error):
                self.view.displayError(title: "Error", error: error)
            case .success(let listings):
                self.displayMarketplaceListings(listings)
            }
            self.view.setLoadingIndicatorVisible(false)
            callback()
        }
    }
    
    public func reloadMarketplaceListings() {
        displayMarketplaceListings()
    }
    
    private func displayMarketplaceListings(_ listings: [MarketplaceListing]? = nil) {
        if let listings = listings ?? (try? marketplaceService.getAllMarketplaceListings()) {
            view.showMarketplaceListings(listings)
        }
    }
    
    public var viewController: UIViewController {
        return view.viewController
    }
    
}
