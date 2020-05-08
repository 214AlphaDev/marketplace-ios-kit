//
//  Price+ValueObject.swift
//  MarketplaceKitTests
//
//  Created by Andrii Selivanov on 6/11/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import XCTest
import MarketplaceKit

class Price_ValueObject: XCTestCase {

    func testConvertDecimalAmountStringMethod() {
        XCTAssertEqual(Price.convertDecimalAmountString("1.00", for: .usd)?.description, "100")
        XCTAssertEqual(Price.convertDecimalAmountString("123.1", for: .usd)?.description, "12310")
        XCTAssertEqual(Price.convertDecimalAmountString("123.10", for: .usd)?.description, "12310")
        XCTAssertEqual(Price.convertDecimalAmountString("123", for: .usd)?.description, "12300")
        
        XCTAssertNil(Price.convertDecimalAmountString("123.999", for: .usd))
        XCTAssertNil(Price.convertDecimalAmountString("123.1.0", for: .usd))
        XCTAssertNil(Price.convertDecimalAmountString("1.001", for: .usd))
    }

}
