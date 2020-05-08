//
//  MarketplaceListingCreatePresenter.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import FlowKit

public class MarketplaceListingCreatePresenter: MarketplaceListingCreatePresenterProtocol {
    
    public var delegate: WeakWrapper<MarketplaceListingCreatePresenterDelegate> = WeakWrapper()
    public let view: MarketplaceListingCreateViewProtocol
    private var creatingListing: CreatingMarketplaceListing = CreatingMarketplaceListing()
    private let marketplaceService: MarketplaceServiceProtocol
    private var priceAmountString = ""
    private var priceCurrency: Currency?
    
    public init(view: MarketplaceListingCreateViewProtocol, marketplaceService: MarketplaceServiceProtocol, draft: CreatingMarketplaceListing? = nil) {
        self.view = view
        self.marketplaceService = marketplaceService
        view.presenter = WeakWrapper(self)
        
        if let draft = draft {
            self.creatingListing = draft
        }
    }
    
    public func setName(_ name: String) {
        self.creatingListing.name = name
    }
    
    public func setDescription(_ description: String) {
        self.creatingListing.description = description
    }
    
    public func setListingPhoto(_ image: UIImage?) {
        guard let image = image else {
            self.creatingListing.photo = nil
            return
        }
        
        do {
            self.creatingListing.photo = try ListingPhoto(image)
        } catch {
            view.displayError(title: "Error", error: error)
        }
    }
    
    public func setPriceAmount(_ amount: String) {
        self.priceAmountString = amount
        setPrice()
    }
    
    public func setCurrency(_ currency: Currency) {
        self.priceCurrency = currency
        setPrice()
    }
    
    public func setPrice() {
        if let currency = self.priceCurrency, let amount = Price.convertDecimalAmountString(priceAmountString, for: currency) {
            self.creatingListing.price = try? Price(amount: amount, currency: currency)
        }
    }
    
    public func supportedCurrencies() -> [Currency] {
        return Array(Currency.codes.keys)
    }
    
    public func submit() {
        view.setLoadingIndicatorVisible(true)
        marketplaceService.createMarketplaceListing(creatingListing) { [weak self] response in
            guard let self = self else { return }
            
            do {
                switch response {
                case .failure(let error):
                    throw error
                case .success(_):
                    self.view.setLoadingIndicatorVisible(false)
                    try self.delegate.wrapped?.presenterRequestNavigateToMarketplaceListScreen(self)
                    self.clear()
                }
            } catch {
                self.view.setLoadingIndicatorVisible(false)
                self.view.displayError(title: "Error", error: error)
            }
        }
    }
    
    public func cancel() {
        do {
            try delegate.wrapped?.presenterRequestNavigateToMarketplaceListScreen(self)
        } catch {
            view.displayError(title: "Error", error: error)
        }
    }
    
    public func clear() {
        self.creatingListing = CreatingMarketplaceListing()
        self.view.setDraft(creatingListing)
    }
    
    // MARK: Validation
    
    public func validate(field: MarketplaceListingCreateValidationField) -> ValidationResult {
        // TODO: Move validation to value objects
        switch field {
        case .description(let description):
            return description.count < 30 ? .invalid(ValidationError.invalidTooSmallMarketplaceListingDescription) : .valid
        case .name(let name):
            return name.count < 5 ? .invalid(ValidationError.invalidTooSmallMarketplaceListingName) : .valid
        case .price(let amountString, let currency):
            guard let amount = Price.convertDecimalAmountString(amountString, for: currency) else {
                return .invalid(ValidationError.invalidPriceAmount)
            }
            
            do {
                _ = try Price(amount: amount, currency: currency)
                return .valid
            } catch {
                return .invalid(error)
            }
        }
    }
    
    // MARK: ViewControllerProvider
    
    public var viewController: UIViewController {
        return view.viewController
    }
    
}
