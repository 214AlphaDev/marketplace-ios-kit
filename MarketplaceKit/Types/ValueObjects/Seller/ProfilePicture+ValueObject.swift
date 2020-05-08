//
//  ProfilePicture+ValueObject.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/10/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import UIKit

public struct ProfilePicture {
    
    public let picture: UIImage
    public let pictureDataString: String
    public init(_ picture: UIImage) throws {
        self.picture = picture
        
        guard let data = picture.jpegData(compressionQuality: 0.8) else {
            throw ValidationError.invalidProfilePicture
        }
        
        self.pictureDataString = data.base64EncodedString(options: .lineLength64Characters)
    }
    
    public init(_ pictureData: String) throws {
        guard let data = Data(base64Encoded: pictureData), let image = UIImage(data: data) else {
            throw ValidationError.invalidProfilePictureData
        }
        
        self.picture = image
        self.pictureDataString = pictureData
    }
    
    public static func from(dataString: String?) throws -> ProfilePicture? {
        if let photoData = dataString {
            return try ProfilePicture(photoData)
        }
        
        return nil
    }
    
}
