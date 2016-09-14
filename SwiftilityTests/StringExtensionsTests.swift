//
//  StringExtensionsTests.swift
//  Swiftility
//
//  Created by Allan Barbato on 3/24/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation
import XCTest
@testable import Swiftility

class StringExtensionsTests: XCTestCase
{
    func testLength()
    {
        let str = "123"
        
        XCTAssert(str.length == 3)
        XCTAssert(str.length == str.characters.count)
    }
    
    func testSubscript()
    {
        let str = "012345"
        let char: Character = str[0]
        
        XCTAssert(char == Character("0"))
        XCTAssert(str[0] == "0")
        
        XCTAssert(str[0...1] == "01")
        XCTAssert(str[0...2] == "012")
        XCTAssert(str[2...4] == "234")
        XCTAssert(str[0..<2] == "01")
    }
}
