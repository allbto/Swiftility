//
//  XCFatalError.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/21/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import XCTest
@testable import Swiftility

extension XCTestCase
{
    func expectFatalError(_ expectedMessage: String = "", testcase: @escaping () -> Void)
    {
        // arrange
        let fatalErrorExpectation = expectation(description: "expectingFatalError")
        var fatalErrorWasCalled: Bool = false
        
        // override fatalError. This will pause forever when fatalError is called.
        FatalErrorUtil.replaceFatalError { message, file, line in
            print("expected fatal error: \(message): file \(file): line \(line)")
            fatalErrorWasCalled = true
            fatalErrorExpectation.fulfill()
        }
        
        // act, perform on separate thead because a call to fatalError pauses forever
        DispatchQueue.global(qos: .userInitiated).async(execute: testcase)
        
        waitForExpectations(timeout: 0.5) { _ in
            // assert
            XCTAssertEqual(fatalErrorWasCalled, true, expectedMessage)
            
            // clean up
            FatalErrorUtil.restoreFatalError()
        }
    }
}
