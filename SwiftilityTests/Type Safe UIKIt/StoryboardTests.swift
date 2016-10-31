//
//  StoryboardTests.swift
//  SwiftilityTests
//
//  Created by Allan Barbato on 12/14/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import XCTest
@testable import Swiftility

class StoryboardTests: XCTestCase
{
    let storyboard = UIStoryboard(name: "MainStoryboard", bundle: Bundle(for: StoryboardTests.self))

    func testStoryboardSafeTypeInstantiation()
    {
        // Test view controller that doesn't exist
        expectFatalError("Instantiate view controller that doesn't exist") {
            _ = self.storyboard.instantiateViewController() as TestNonExistingVC
        }
        
        // Test view controller that does exist
        let existingVC: TestVC = storyboard.instantiateViewController()
        
        XCTAssert(true, "existingVC(\(existingVC)) instantiation should not crash")
    }
    
    func testStoryboardName()
    {
        // Define default storyboard convertible type
        let sbc: UIStoryboard.Name = .mainDefault
        
        XCTAssert(sbc.name == "MainStoryboard")
        XCTAssert(sbc.bundle == nil)
        
        // Define test storyboard convertible type
        let sbc2: UIStoryboard.Name = .mainTests

        XCTAssert(sbc2.name == "MainStoryboard")
        XCTAssert(sbc2.bundle != nil)
        
        let storyboard = UIStoryboard(name: sbc2)
        
        XCTAssert(true, "storyboard(\(storyboard)) instantiation should not crash")
    }
    
    func testInitialViewController()
    {
        // Test initial view controller that doesn't exist
        expectFatalError("Instantiate initial view controller that doesn't exist") {
            _ = self.storyboard.instantiateInitialViewController() as TestNonExistingVC
        }
        
        // Test initial view controller that does exist
        let existingVC: TestVC = storyboard.instantiateInitialViewController()
        
        XCTAssert(true, "existingVC(\(existingVC)) instantiation should not crash")
    }
}






