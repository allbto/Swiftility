//
//  RegexTests.swift
//  Swiftility
//
//  Created by Allan Barbato on 12/16/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import XCTest
@testable import Swiftility

class RegexTests: XCTestCase
{
    func testMatch()
    {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        XCTAssert("allan.bto+test34@allan.com" =~ emailRegEx, "regex doesn't validate email")
        XCTAssert(!("allan.bto+test34@" =~ emailRegEx), "regex validates wrong email")

        XCTAssert("allan.bto+test34@allan.com".match(pattern: emailRegEx), "regex doesn't validate email")
        
        do {
            let regex = try Regex(pattern: emailRegEx)
            XCTAssert("allan.bto+test34@allan.com".match(regex: regex), "regex doesn't validate email")
        } catch {
            XCTAssert(false, "Regex fails to instantiate")
        }
    }
    
    func testReplace()
    {
        XCTAssertEqual("I am a developer fixing bugs".replace(pattern: "fixing bugs", template: "implementing features"),
            "I am a developer implementing features",
            "regex doesn't replace correctly")
        
        do {
            let regex = try Regex(pattern:"fixing bugs")
            XCTAssertEqual("I am a developer fixing bugs".replace(regex: regex, template: "implementing features"),
                "I am a developer implementing features",
                "regex doesn't replace correctly")
        } catch {
            XCTAssert(false, "Regex fails to instantiate")
        }
        
        XCTAssertEqual("I am a developer doing <weird>stuff</weird>".replace(pattern: "<[a-z]+>([a-z]+)</[a-z]+>", template: "normal $1"),
            "I am a developer doing normal stuff",
            "regex doesn't replace correctly")
    }
}
