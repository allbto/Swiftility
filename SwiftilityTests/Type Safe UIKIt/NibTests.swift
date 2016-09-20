//
//  NibTests.swift
//  SwiftilityTests
//
//  Created by Allan Barbato on 12/14/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import XCTest
@testable import Swiftility

class NibTests: XCTestCase
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
    
    func testNibConvertible()
    {
        let nib = NibsDefault.TestCell
        
        XCTAssert(nib.nibName == "TestCell")
        XCTAssert(nib.bundle == nil)
    }
    
    func testInstantiateFromNib()
    {
//        expectFatalError {
//            TestNonExistingCell.instantiateFromNib(NibContainer("TestNonExistingCell", bundle: NSBundle(forClass: self.dynamicType)))
//        }
        
        _ = TestCell.instantiateFromNib()

        XCTAssert(true, "cell instantiation should not crash")
    }
}






