//
//  MarketplaceListingCreate+MVP.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public protocol MarketplaceListingCreatePresenterDelegate: class {
    
    func presenterRequestNavigateToMarketplaceListScreen(_ presenter: MarketplaceListingCreatePresenterProtocol) throws
    
}

public enum MarketplaceListingCreateValidationField {
    case name(String)
    case description(String)
    case price(amount: String, currency: Currency)
}

public protocol MarketplaceListingCreatePresenterProtocol: Presenter {
    
    var delegate: WeakWrapper<MarketplaceListingCreatePresenterDelegate> { get set }
    var view: MarketplaceListingCreateViewProtocol { get }
    
    func setName(_ name: String)
    func setDescription(_ description: String)
    func setListingPhoto(_ image: UIImage?)
    func setPriceAmount(_ amount: String)
    func setCurrency(_ currency: Currency)
    func supportedCurrencies() -> [Currency]
    func validate(field: MarketplaceListingCreateValidationField) -> ValidationResult
    func submit()
    func cancel()
    func clear()
    
}

public protocol MarketplaceListingCreateViewProtocol: class, ViewControllerProvider, ErrorDisplayable, LoadingIndicatorDisplayable {
    
    var presenter: WeakWrapper<MarketplaceListingCreatePresenterProtocol> { get set }
    
    func setDraft(_ draft: CreatingMarketplaceListing)
    
}
