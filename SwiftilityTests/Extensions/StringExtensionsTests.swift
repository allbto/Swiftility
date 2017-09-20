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
    func testSubscript()
    {
        let str = "012345"
        let char: Character = str[0]
        
        XCTAssert(char == Character("0"))
        XCTAssert(str[0] == "0")
        
        XCTAssert(str[0..<2] == "01")
        XCTAssert(str[0..<3] == "012")
        XCTAssert(str[2..<5] == "234")
    }
    
    func testTrim()
    {
        let str = "            t     es       t              "
        
        XCTAssert(str.trimmed() == "t     es       t")
        XCTAssert("test".trimmed() == "test")
    }
    
    func testWords()
    {
        XCTAssert("".words.isEmpty)
        XCTAssert("Hello".words == ["Hello"])
        XCTAssert("Hello World".words == ["Hello", "World"])
        XCTAssert("   %^&  +))  Hello       World!   #$%^&<>?     ".words == ["Hello", "World"])
        XCTAssert("   😀    Hello    😀😬🙏☝🏼👂🏿👽     World!     😀   ".words == ["Hello", "World"])
    }
    
    func testUrlEncoded()
    {
        XCTAssert(";?/:#&=+$, %<>~%".urlEncoded() == "%3B%3F%2F%3A%23%26%3D%2B%24%2C%20%25%3C%3E%7E%25")
        XCTAssert("https://www.toto.co.uk/toto/tutu?hello=titi&asasas=tre".urlEncoded() == "https%3A%2F%2Fwww.toto.co.uk%2Ftoto%2Ftutu%3Fhello%3Dtiti%26asasas%3Dtre")
    }
    
    func testTruncated()
    {
        XCTAssert("toto".truncated(-1) == "toto")
        XCTAssert("toto".truncated(0) == "")
        XCTAssert("toto".truncated(1) == "t")
        XCTAssert("toto".truncated(2) == "to")
        XCTAssert("toto".truncated(3) == "tot")
        XCTAssert("toto".truncated(4) == "toto")
        XCTAssert("toto".truncated(50) == "toto")
    }
}
