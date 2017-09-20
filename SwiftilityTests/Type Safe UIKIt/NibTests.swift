//
//  NibTests.swift
//  SwiftilityTests
//
//  Created by Allan Barbato on 12/14/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import XCTest
import Nimble
@testable import Swiftility

class NibTests: XCTestCase
{
    let storyboard = UIStoryboard(name: "MainStoryboard", bundle: Bundle(for: StoryboardTests.self))

    func testNibConvertible()
    {
        let nib = NibsDefault.TestCell
        
        XCTAssert(nib.nibName == "TestCell")
        XCTAssert(nib.bundle == nil)
    }
    
    func testInstantiateFromNib()
    {
        // Instantiate non existing nib
        
        expect {
            _ = TestNonExistingCell.instantiateFromNib(NibContainer("TestNonExistingCell", bundle: Bundle(for: StoryboardTests.self)))
        }.to(throwAssertion())
        
        // Instantiate existing nib

        _ = TestCell.instantiateFromNib()

        XCTAssert(true, "cell instantiation should not crash")
    }
}






