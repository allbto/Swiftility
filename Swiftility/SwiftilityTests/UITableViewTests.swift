//
//  UITableViewTests.swift
//  Swiftility
//
//  Created by Allan Barbato on 1/31/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import XCTest
import Nimble
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
        
        expect(tableView.registerCell(TestCell)).toNot(raiseException())
        
        expectFatalError {
            tableView.dequeueReusableCell(TestNonExistingCell)
        }
        
        expect(tableView.dequeueReusableCell(TestCell)).to(beTruthy())
    }

    func testDequeueCellOnViewController()
    {
        let tableVC = TestTableVC.instantiateFromStoryboard()
        
        expect(tableVC).to(beTruthy())

        expectFatalError {
            tableVC.tableView.dequeueReusableCell(TestNonExistingCell)
        }

        expect(tableVC.tableView.dequeueReusableCell(TestCell)).to(beTruthy())
    }
}
