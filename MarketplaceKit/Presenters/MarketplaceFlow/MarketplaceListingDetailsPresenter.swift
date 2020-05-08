//
//  MarketplaceListingDetailsPresenter.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit
import CommunityKit

public class MarketplaceListingDetailsPresenter: MarketplaceListingDetailsPresenterProtocol {
    
    public var delegate: WeakWrapper<MarketplaceListingDetailsPresenterDelegate> = WeakWrapper()
    public let view: MarketplaceListingDetailsViewProtocol
    private let marketplaceService: MarketplaceServiceProtocol
    private var marketplaceListing: MarketplaceListing
    
    public init(view: MarketplaceListingDetailsViewProtocol, marketplaceListing: MarketplaceListing, marketplaceService: MarketplaceServiceProtocol, memberService: MemberServiceProtocol) {
        self.view = view
        self.marketplaceService = marketplaceService
        self.marketplaceListing = marketplaceListing
        view.presenter = WeakWrapper(self)
        
        if let creatorOptionalId = try? memberService.getCurrentMember()?.id, let creatorId = creatorOptionalId {
            let isCreator = creatorId.id == marketplaceListing.sellerId.id
            view.setEditAllowed(isCreator)
            view.setIsListedByCurrentMember(isCreator)
        } else {
            view.setEditAllowed(false)
            view.setIsListedByCurrentMember(false)
        }
        
        passListingToView()
    }
    
    public func edit() {
        do {
            try delegate.wrapped?.presenter(self, requestsNavigateToMarketplaceListingEditScreenWith: marketplaceListing)
        } catch {
            view.displayError(title: "Error", error: error)
        }
    }
    
    public func update(with listing: MarketplaceListing) {
        self.marketplaceListing = listing
        
        passListingToView()
    }
    
    public func passListingToView() {
        do {
            let optionalSeller = try marketplaceService.getSeller(id: marketplaceListing.sellerId)
            
            guard let seller = optionalSeller else {
                throw ConsistencyError.noSellerFoundForMarketplaceListing(marketplaceListing)
            }
            
            view.displayMarketplaceListing(marketplaceListing, seller: seller)
        } catch {
            view.displayError(title: "Error", error: error)
        }
    }
    
    public var viewController: UIViewController {
        return view.viewController
    }
    
}
