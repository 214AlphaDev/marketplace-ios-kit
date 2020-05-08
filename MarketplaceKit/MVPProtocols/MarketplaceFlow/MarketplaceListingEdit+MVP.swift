//
//  MarketplaceListingEdit+MVP.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 5/27/19.
//  Copyright © 2019 214Alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol MarketplaceListingEditPresenterDelegate: class {
    
    func presenter(_ presenter: MarketplaceListingEditPresenterProtocol, requestNavigateBackWith updatedListing: MarketplaceListing) throws
    
}

public enum MarketplaceListingEditValidationField {
    case name(String)
    case description(String)
    case price(amount: String, currency: Currency)
}

public protocol MarketplaceListingEditPresenterProtocol: Presenter {
    
    var delegate: WeakWrapper<MarketplaceListingEditPresenterDelegate> { get set }
    var view: MarketplaceListingEditViewProtocol { get }
    
    func setName(_ name: String)
    func setDescription(_ description: String)
    func setListingPhoto(_ image: UIImage?)
    func setPriceAmount(_ amount: String)
    func setCurrency(_ currency: Currency)
    func supportedCurrencies() -> [Currency]
    func validate(field: MarketplaceListingEditValidationField) -> ValidationResult
    func submit()
    func cancel()
    
}

public protocol MarketplaceListingEditViewProtocol: class, ViewControllerProvider, ErrorDisplayable, LoadingIndicatorDisplayable {
    
    var presenter: WeakWrapper<MarketplaceListingEditPresenterProtocol> { get set }
    
    func setMarketplaceListing(_ listing: MarketplaceListing)
    
}
