//
//  ArrayExtensionsTests.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/21/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation
import XCTest
@testable import Swiftility

class ArrayExtensionsTests: XCTestCase
{
    func testGet()
    {
        let arr = ["0", "1", "2"]

        XCTAssert(arr.get(0) == "0")
        XCTAssert(arr.get(-0) == "0")
        XCTAssert(arr.get(-1) == nil)
        XCTAssert(arr.get(2) == "2")
        XCTAssert(arr.get(3) == nil)
        XCTAssert(arr.get(99999999999) == nil)
        XCTAssert(arr.get(-99999999999) == nil)
    }
    
    func testRemove()
    {
        var arr = ["0", "1", "2"]
        
        let removedIndex = arr.remove("0")
        XCTAssert(arr == ["1", "2"])
        XCTAssert(removedIndex == 0)
        
        let notRemovedIndex = arr.remove("3")
        XCTAssert(arr == ["1", "2"])
        XCTAssert(notRemovedIndex == nil)
    }
}
