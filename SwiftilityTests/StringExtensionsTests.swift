//
//  StringExtensionsTests.swift
//  Swiftility
//
//  Created by Allan Barbato on 3/24/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation
import XCTest
import Nimble
@testable import Swiftility

class StringExtensionsTests: XCTestCase
{
    func testLength()
    {
        let str = "123"
        
        expect(str.length) == 3
        expect(str.length) == str.characters.count
    }
    
    func testSubscript()
    {
        let str = "012345"
        let char: Character = str[0]
        
        expect(char) == Character("0")
        expect(str[0]) == "0"
        
        expect(str[0...1]) == "01"
        expect(str[0...2]) == "012"
        expect(str[2...4]) == "234"
        expect(str[0..<2]) == "01"
    }
}