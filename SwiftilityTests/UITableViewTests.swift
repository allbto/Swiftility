//
//  UITableViewTests.swift
//  Swiftility
//
//  Created by Allan Barbato on 1/31/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import XCTest
@testable import Swiftility

class UITableViewTests: XCTestCase
{
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testDequeueCell()
    {
        let tableView = UITableView(frame: CGRectZero, style: .Grouped)
        
        tableView.registerCell(TestCell)
        
        XCTAssert(true, "registerCell should not crash")
        
//        expectFatalError {
//            tableView.dequeueReusableCell(TestNonExistingCell)
//        }
        
        let cell: TestCell = tableView.dequeueReusableCell()
        
        XCTAssert(true, "dequeueReusableCell should not crash")
    }

    func testDequeueCellOnViewController()
    {
        let tableVC = TestTableVC.instantiateFromStoryboard()
        
        XCTAssert(true, "tableVC instatiation should not crash")

//        expectFatalError {
//            tableVC.tableView.dequeueReusableCell(TestNonExistingCell)
//        }

        let cell: TestCell = tableVC.tableView.dequeueReusableCell()
        
        XCTAssert(true, "dequeueReusableCell should not crash")
    }
}