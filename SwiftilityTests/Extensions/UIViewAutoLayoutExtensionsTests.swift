//
//  UIViewAutoLayoutExtensionsTests.swift
//  Swiftility
//
//  Created by Allan Barbato on 11/10/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import XCTest
@testable import Swiftility

final class UIViewAutoLayoutExtensionsTests: XCTestCase
{
    var view: UIView!
    var superview: UIView!
    
    override func setUp()
    {
        super.setUp()
     
        superview = UIView()
        view = UIView()
    }
    
    func testAutoAttach()
    {
        view.autoAttach(to: superview) { _ in }
        
        XCTAssert(view.superview == superview)
        XCTAssert(view.translatesAutoresizingMaskIntoConstraints == false)
    }

    func testAutoPinFailure()
    {
        XCTAssert(view.superview == nil)
        
        expectFatalError {
            self.view.autoPin(.top)
        }
    }
    
    func testAutoPinSimple()
    {
        var constraint: NSLayoutConstraint!
        
        view.autoAttach(to: superview) {
            constraint = $0.autoPin(.top)
        }
        
        XCTAssertEqual((constraint.firstItem as! UIView), view)
        XCTAssertEqual(constraint.firstAttribute, .top)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssertEqual((constraint.secondItem as! UIView), superview)
        XCTAssertEqual(constraint.secondAttribute, .top)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.priority, UILayoutPriorityRequired)
    }
    
    func testAutoPinFull()
    {
        var constraint: NSLayoutConstraint!
        let otherView = UIView()
        
        view.autoAttach(to: superview) {
            constraint = $0.autoPin(.top, relatedBy: .greaterThanOrEqual, toItem: otherView, toAttribute: .bottom, multiplier: 2, constant: 25, priority: UILayoutPriorityDefaultLow)
        }
        
        XCTAssertEqual((constraint.firstItem as! UIView), view)
        XCTAssertEqual(constraint.firstAttribute, .top)
        XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        XCTAssertEqual((constraint.secondItem as! UIView), otherView)
        XCTAssertEqual(constraint.secondAttribute, .bottom)
        XCTAssertEqual(constraint.multiplier, 2)
        XCTAssertEqual(constraint.constant, 25)
        XCTAssertEqual(constraint.priority, UILayoutPriorityDefaultLow)
    }

    func testAutoPinNotAnAttribute()
    {
        var constraint: NSLayoutConstraint!
        var constraint2: NSLayoutConstraint!
        
        view.autoAttach(to: superview) {
            constraint = $0.autoPin(.width, toItem: nil, toAttribute: .bottom)
            constraint2 = $0.autoPin(.height, toItem: nil)
        }
        
        XCTAssertEqual((constraint.firstItem as! UIView), view)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.relation, .equal)
        XCTAssert(constraint.secondItem == nil)
        XCTAssertEqual(constraint.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraint.multiplier, 1)
        XCTAssertEqual(constraint.constant, 0)
        XCTAssertEqual(constraint.priority, UILayoutPriorityRequired)

        XCTAssertEqual((constraint2.firstItem as! UIView), view)
        XCTAssertEqual(constraint2.firstAttribute, .height)
        XCTAssertEqual(constraint2.relation, .equal)
        XCTAssert(constraint2.secondItem == nil)
        XCTAssertEqual(constraint2.secondAttribute, .notAnAttribute)
        XCTAssertEqual(constraint2.multiplier, 1)
        XCTAssertEqual(constraint2.constant, 0)
        XCTAssertEqual(constraint2.priority, UILayoutPriorityRequired)
    }
}
