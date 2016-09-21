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
