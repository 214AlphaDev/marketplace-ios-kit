//
//  ListingPhoto+ValueObject.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/6/19.
//  Copyright © 2019 214Alpha. All rights reserved.
//

import Foundation
import UIKit

public struct ListingPhoto {
    
    public let picture: UIImage
    public let pictureDataString: String
    public init(_ picture: UIImage) throws {
        self.picture = picture
        
        guard let data = picture.jpegData(compressionQuality: 1.0) else {
            throw ValidationError.invalidListingPhoto
        }
        
        self.pictureDataString = data.base64EncodedString(options: .lineLength64Characters)
    }
    
    public init(_ pictureData: String) throws {
        guard let data = Data(base64Encoded: pictureData), let image = UIImage(data: data) else {
            throw ValidationError.invalidListingPhotoPictureData
        }
        
        self.picture = image
        self.pictureDataString = pictureData
    }
    
    public static func from(dataString: String?) throws -> ListingPhoto? {
        if let photoData = dataString {
            return try ListingPhoto(photoData)
        }
    
        return nil
    }
    
}
