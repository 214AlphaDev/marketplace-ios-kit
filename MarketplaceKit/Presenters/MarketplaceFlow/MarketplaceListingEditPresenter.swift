//
//  MarketplaceListingEditPresenter.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 5/27/19.
//  Copyright © 2019 214Alpha. All rights reserved.
//

import Foundation
import FlowKit

public class MarketplaceListingEditPresenter: MarketplaceListingEditPresenterProtocol {
    
    public var delegate: WeakWrapper<MarketplaceListingEditPresenterDelegate> = WeakWrapper()
    public let view: MarketplaceListingEditViewProtocol
    private let originalListing: MarketplaceListing
    private var modifiedListing: CreatingMarketplaceListing
    private let marketplaceService: MarketplaceServiceProtocol
    private var priceAmountString = ""
    private var priceCurrency: Currency?
    
    public init(view: MarketplaceListingEditViewProtocol, marketplaceService: MarketplaceServiceProtocol, marketplaceListing: MarketplaceListing) {
        self.view = view
        self.marketplaceService = marketplaceService
        self.originalListing = marketplaceListing
        self.modifiedListing = CreatingMarketplaceListing(marketplaceListing: marketplaceListing)
        self.priceAmountString = marketplaceListing.price.amountDesription
        self.priceCurrency = marketplaceListing.price.currency
        
        view.presenter = WeakWrapper(self)
        
        view.setMarketplaceListing(marketplaceListing)
    }
    
    public func setName(_ name: String) {
        self.modifiedListing.name = name
    }
    
    public func setDescription(_ description: String) {
        self.modifiedListing.description = description
    }
    
    public func setListingPhoto(_ image: UIImage?) {
        guard let image = image else {
            self.modifiedListing.photo = nil
            return
        }
        
        do {
            self.modifiedListing.photo = try ListingPhoto(image)
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
            self.modifiedListing.price = try? Price(amount: amount, currency: currency)
        } else {
            self.modifiedListing.price = nil
        }
    }
    
    public func supportedCurrencies() -> [Currency] {
        return Array(Currency.codes.keys)
    }
    
    public func submit() {
        view.setLoadingIndicatorVisible(true)
        marketplaceService.editMarketplaceListing(with: originalListing.id, modifiedListing: modifiedListing) { [weak self] response in
            guard let self = self else { return }
            
            do {
                switch response {
                case .failure(let error):
                    throw error
                case .success(let updatedListing):
                    self.view.setLoadingIndicatorVisible(false)
                    try self.delegate.wrapped?.presenter(self, requestNavigateBackWith: updatedListing)
                }
            } catch {
                self.view.setLoadingIndicatorVisible(false)
                self.view.displayError(title: "Error", error: error)
            }
        }
    }
    
    public func cancel() {
        do {
            try delegate.wrapped?.presenter(self, requestNavigateBackWith: self.originalListing)
        } catch {
            view.displayError(title: "Error", error: error)
        }
    }
    
    // MARK: Validation
    
    public func validate(field: MarketplaceListingEditValidationField) -> ValidationResult {
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
