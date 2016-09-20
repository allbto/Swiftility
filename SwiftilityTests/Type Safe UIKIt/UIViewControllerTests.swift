//
//  UIViewControllerTests.swift
//  Swiftility
//
//  Created by Allan Barbato on 1/31/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import XCTest
@testable import Swiftility

class UIViewControllerTests: XCTestCase
{
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInstantiateFromStoryboard()
    {
        _ = TestVC.instantiateFromStoryboard()
        XCTAssert(true, "vc instantiation should not crash")
    }
    
    func testNibConvertible()
    {
        XCTAssert(TestVC.ownNib.nibName == "TestVC")
        XCTAssert(TestVC.ownNib.bundle == nil)
    }
    
    func testViewNibConvertible()
    {
        XCTAssert(TestView.ownNib.nibName == "TestView")
        XCTAssert(TestView.ownNib.bundle == nil)
    }
}
