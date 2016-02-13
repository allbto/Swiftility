//
//  StoryboardTests.swift
//  SwiftilityTests
//
//  Created by Allan Barbato on 12/14/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import XCTest
import Nimble
@testable import Swiftility

class StoryboardTests: XCTestCase
{
    let storyboard = UIStoryboard(name: "MainStoryboard", bundle: NSBundle(forClass: StoryboardTests.self))

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
        let nonExistingVC = storyboard.silentlyInstantiateViewControllerWithIdentifier("TestViewController")
        
        expect(nonExistingVC).to(beNil())
        
        // Test view controller that does exist
        let existingVC = storyboard.silentlyInstantiateViewControllerWithIdentifier("TestVC")
        
        expect(existingVC).toNot(beNil())
    }
    
    func testStoryboardSafeTypeInstantiation()
    {
        // Test view controller that doesn't exist
//        expectFatalError {
//            self.storyboard.instantiateViewController(TestNonExistingVC)
//        }
        
        // Test view controller that does exist
        let existingVC = storyboard.instantiateViewController(TestVC)
        
        expect(existingVC).to(beTruthy())
    }
    
    func testStoryboardCompatible()
    {
        // Define default storyboard convertible type
        let sbc: StoryboardConvertible = StoryboardsDefault.MainStoryboard
        
        expect(sbc.storyboardName) == "MainStoryboard"
        expect(sbc.bundle).to(beNil())
        
        // Define test storyboard convertible type
        let sbc2: StoryboardConvertible = StoryboardsTests.MainStoryboard

        expect(sbc2.storyboardName) == "MainStoryboard"
        expect(sbc2.bundle).toNot(beNil())
        expect(sbc2.storyboard).toNot(raiseException())
    }
    
    func testInitialViewController()
    {
        // Test initial view controller that doesn't exist
//        expectFatalError {
//            self.storyboard.instantiateInitialViewController(TestNonExistingVC)
//        }
        
        // Test initial view controller that does exist
        let existingVC = storyboard.instantiateInitialViewController(TestVC)
        
        expect(existingVC).to(beTruthy())
    }
}






