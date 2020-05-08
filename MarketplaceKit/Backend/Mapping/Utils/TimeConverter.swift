//
//  TimeConverter.swift
//  MarketplaceKit
//
//  Created by Andrii Selivanov on 6/10/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

struct TimeConverter {
    
    static let dateFormatter = { () -> DateFormatter in
        let en_US_POSIX = Locale(identifier: "en_US_POSIX")
        let rfc3339DateFormatter = DateFormatter()
        rfc3339DateFormatter.locale = en_US_POSIX
        rfc3339DateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
        rfc3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return rfc3339DateFormatter
    }()
    
    static func convertToDate(timeString: String) -> Date? {
        return dateFormatter.date(from: timeString)
    }
    
}
