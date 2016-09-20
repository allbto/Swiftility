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

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testStoryboardSilentlyInstantiate()
    {
        // Test view controller that doesn't exist
        let nonExistingVC = storyboard.silentlyInstantiateViewController(withIdentifier: "TestViewController")
        
        XCTAssert(nonExistingVC == nil)
        
        // Test view controller that does exist
        let existingVC = storyboard.silentlyInstantiateViewController(withIdentifier: "TestVC")
        
        XCTAssert(existingVC != nil)
    }
    
    func testStoryboardSafeTypeInstantiation()
    {
        // Test view controller that doesn't exist
//        expectFatalError {
//            self.storyboard.instantiateViewController(TestNonExistingVC)
//        }
        
        // Test view controller that does exist
        let existingVC: TestVC = storyboard.instantiateViewController()
        
        XCTAssert(true, "existingVC(\(existingVC)) instantiation should not crash")
    }
    
    func testStoryboardCompatible()
    {
        // Define default storyboard convertible type
        let sbc: StoryboardConvertible = StoryboardsDefault.MainStoryboard
        
        XCTAssert(sbc.storyboardName == "MainStoryboard")
        XCTAssert(sbc.bundle == nil)
        
        // Define test storyboard convertible type
        let sbc2: StoryboardConvertible = StoryboardsTests.MainStoryboard

        XCTAssert(sbc2.storyboardName == "MainStoryboard")
        XCTAssert(sbc2.bundle != nil)
        
        let storyboard = sbc2.storyboard
        
        XCTAssert(true, "storyboard(\(storyboard)) instantiation should not crash")
    }
    
    func testInitialViewController()
    {
        // Test initial view controller that doesn't exist
//        expectFatalError {
//            self.storyboard.instantiateInitialViewController(TestNonExistingVC)
//        }
        
        // Test initial view controller that does exist
        let existingVC: TestVC = storyboard.instantiateInitialViewController()
        
        XCTAssert(true, "existingVC(\(existingVC)) instantiation should not crash")
    }
}






