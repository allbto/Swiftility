//
//  UIViewControllerTests.swift
//  Swiftility
//
//  Created by Allan Barbato on 1/31/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import XCTest
import Nimble
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
        expect(TestVC.instantiateFromStoryboard()).to(beTruthy())
    }
    
    func testNibConvertible()
    {
        expect(TestVC.ownNib.nibName) == "TestVC"
        expect(TestVC.ownNib.bundle).to(beNil())
    }
    
    func testViewNibConvertible()
    {
        expect(TestView.ownNib.nibName) == "TestView"
        expect(TestView.ownNib.bundle).to(beNil())
    }
}
