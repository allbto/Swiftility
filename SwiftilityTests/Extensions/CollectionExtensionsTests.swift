//
//  CollectionExtensionsTests.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/21/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation
import XCTest
@testable import Swiftility

class CollectionExtensionsTests: XCTestCase
{
    func testMapOptional()
    {
        let arr: [Int?] = [1, nil, 0, 12, nil, 0, 2]
        let arrCleaned = arr.mapOptional({ $0 })

        XCTAssert(arrCleaned == [1, 0, 12, 0, 2])
        XCTAssert(arrCleaned.mapOptional({ $0 > 1 ? $0 : nil }) == [12, 2])
    }
}
