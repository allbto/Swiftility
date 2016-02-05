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
    
    func testInstanciateFromStoryboard()
    {
        expect(TestVC.instantiateFromStoryboard()).to(beTruthy())
    }
    
    func testNibConvertible()
    {
        expect(TestVC.nib.nibName) == "TestVC"
        expect(TestVC.nib.bundle).to(beNil())
    }
    
    func testViewNibConvertible()
    {
        expect(TestView.nib.nibName) == "TestView"
        expect(TestView.nib.bundle).to(beNil())
    }
}
