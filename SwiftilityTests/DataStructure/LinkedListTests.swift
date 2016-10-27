//
//  LinkedListTests.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/11/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import XCTest
@testable import Swiftility

class LinkedListTests: XCTestCase
{
    var list: LinkedList<String>!
    
    override func setUp()
    {
        super.setUp()
        
        list = LinkedList()
        
        XCTAssert(list.count == 0)
        XCTAssert(list.isEmpty == true)
    }
    
    func testAppend()
    {
        list.append(value: "Value0")
        
        XCTAssert(list.count == 1)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list[0] == "Value0")
        XCTAssert(list.debugDescription == "[Value0]")
        
        list.append(value: "Value1")

        XCTAssert(list.count == 2)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list[1] == "Value1")
        XCTAssert(list.debugDescription == "[Value0,Value1]")
        
        list.append(value: "Value2")

        XCTAssert(list.count == 3)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list[2] == "Value2")
        XCTAssert(list.debugDescription == "[Value0,Value1,Value2]")
        
        list.append(value: "Value3")
        
        XCTAssert(list.count == 4)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list[3] == "Value3")
        XCTAssert(list.debugDescription == "[Value0,Value1,Value2,Value3]")
        
        list.append(value: "Value4")

        XCTAssert(list.count == 5)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list[4] == "Value4")
        XCTAssert(list.debugDescription == "[Value0,Value1,Value2,Value3,Value4]")
    }
    
    func testInsertFirst()
    {
        list.insertFirst(value: "Value0")
        
        XCTAssert(list.count == 1)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list[0] == "Value0")
        XCTAssert(list.debugDescription == "[Value0]")
        
        list.insertFirst(value: "Value1")
        
        XCTAssert(list.count == 2)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list[0] == "Value1")
        XCTAssert(list.debugDescription == "[Value1,Value0]")
        
        list.insertFirst(value: "Value2")
        
        XCTAssert(list.count == 3)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list[0] == "Value2")
        XCTAssert(list.debugDescription == "[Value2,Value1,Value0]")
        
        list.insertFirst(value: "Value3")
        
        XCTAssert(list.count == 4)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list[0] == "Value3")
        XCTAssert(list.debugDescription == "[Value3,Value2,Value1,Value0]")
        
        list.insertFirst(value: "Value4")
        
        XCTAssert(list.count == 5)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list[0] == "Value4")
        XCTAssert(list.debugDescription == "[Value4,Value3,Value2,Value1,Value0]")
    }
    
    func testRemoveFirst()
    {
        // Append Values
        
        list.append(value: "Value0")
        list.append(value: "Value1")
        list.append(value: "Value2")
        list.append(value: "Value3")
        list.append(value: "Value4")
        
        XCTAssert(list.count == 5)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value0,Value1,Value2,Value3,Value4]")
        
        // Remove one by one
        
        list.removeFirst()
        
        XCTAssert(list.count == 4)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value1,Value2,Value3,Value4]")
        
        list.removeFirst()
        
        XCTAssert(list.count == 3)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value2,Value3,Value4]")
        
        list.removeFirst()
        
        XCTAssert(list.count == 2)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value3,Value4]")
        
        list.removeFirst()
        
        XCTAssert(list.count == 1)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value4]")
        
        list.removeFirst()
        
        XCTAssert(list.count == 0)
        XCTAssert(list.isEmpty == true)
        XCTAssert(list.debugDescription == "[]")
        
        list.removeFirst()
        
        XCTAssert(list.count == 0)
        XCTAssert(list.isEmpty == true)
        XCTAssert(list.debugDescription == "[]")
        
        // Re-append
        
        list.append(value: "Value0")
        list.append(value: "Value1")
        list.append(value: "Value2")
        list.append(value: "Value3")
        list.append(value: "Value4")
        
        XCTAssert(list.count == 5)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value0,Value1,Value2,Value3,Value4]")
    }
    
    func testRemoveLast()
    {
        // Append Values
        
        list.append(value: "Value0")
        list.append(value: "Value1")
        list.append(value: "Value2")
        list.append(value: "Value3")
        list.append(value: "Value4")
        
        XCTAssert(list.count == 5)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value0,Value1,Value2,Value3,Value4]")
        
        // Remove one by one
        
        list.removeLast()
        
        XCTAssert(list.count == 4)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value0,Value1,Value2,Value3]")
        
        list.removeLast()
        
        XCTAssert(list.count == 3)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value0,Value1,Value2]")
        
        list.removeLast()
        
        XCTAssert(list.count == 2)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value0,Value1]")
        
        list.removeLast()
        
        XCTAssert(list.count == 1)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value0]")
        
        list.removeLast()
        
        XCTAssert(list.count == 0)
        XCTAssert(list.isEmpty == true)
        XCTAssert(list.debugDescription == "[]")
        
        list.removeLast()
        
        XCTAssert(list.count == 0)
        XCTAssert(list.isEmpty == true)
        XCTAssert(list.debugDescription == "[]")
        
        // Re-append
        
        list.append(value: "Value0")
        list.append(value: "Value1")
        list.append(value: "Value2")
        list.append(value: "Value3")
        list.append(value: "Value4")
        
        XCTAssert(list.count == 5)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value0,Value1,Value2,Value3,Value4]")
    }
    
    func testRemoveAt()
    {
        list.append(value: "Value0")
        list.append(value: "Value1")
        list.append(value: "Value2")
        list.append(value: "Value3")
        list.append(value: "Value4")
        
        XCTAssert(list.count == 5)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value0,Value1,Value2,Value3,Value4]")
        
        // Remove at
        
        list.remove(at: 0)

        XCTAssert(list.count == 4)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value1,Value2,Value3,Value4]")

        list.remove(at: 3)
        
        XCTAssert(list.count == 3)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value1,Value2,Value3]")

        list.remove(at: 1)
        
        XCTAssert(list.count == 2)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value1,Value3]")
        
        // Wrong values
        
        list.remove(at: -1)
        
        XCTAssert(list.count == 2)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value1,Value3]")
        
        list.remove(at: 3)
        
        XCTAssert(list.count == 2)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value1,Value3]")
        
        list.remove(at: 999)
        
        XCTAssert(list.count == 2)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value1,Value3]")
        
        //
        
        list.remove(at: 1)
        
        XCTAssert(list.count == 1)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value1]")

        list.remove(at: 0)
        
        XCTAssert(list.count == 0)
        XCTAssert(list.isEmpty == true)
        XCTAssert(list.debugDescription == "[]")

        list.remove(at: 0)
        
        XCTAssert(list.count == 0)
        XCTAssert(list.isEmpty == true)
        XCTAssert(list.debugDescription == "[]")

        // Append values again
        
        list.append(value: "Value0")
        list.append(value: "Value1")
        list.append(value: "Value2")
        list.append(value: "Value3")
        list.append(value: "Value4")
        
        XCTAssert(list.count == 5)
        XCTAssert(list.isEmpty == false)
        XCTAssert(list.debugDescription == "[Value0,Value1,Value2,Value3,Value4]")
    }
    
    func testFirstLast()
    {
        XCTAssert(list.first == nil)
        XCTAssert(list.last == nil)
        
        // Append
        
        list.append(value: "Value0")
        
        XCTAssert(list.first == "Value0")
        XCTAssert(list.last == "Value0")
        
        list.append(value: "Value1")

        XCTAssert(list.first == "Value0")
        XCTAssert(list.last == "Value1")
        
        list.append(value: "Value2")
        
        XCTAssert(list.first == "Value0")
        XCTAssert(list.last == "Value2")
        
        // Insert First
        
        list.insertFirst(value: "Value-1")
        
        XCTAssert(list.first == "Value-1")
        XCTAssert(list.last == "Value2")
        
        list.insertFirst(value: "Value-2")
        
        XCTAssert(list.first == "Value-2")
        XCTAssert(list.last == "Value2")
        
        // Remove First
        
        list.removeFirst()
        
        XCTAssert(list.first == "Value-1")
        XCTAssert(list.last == "Value2")

        list.removeFirst()
        
        XCTAssert(list.first == "Value0")
        XCTAssert(list.last == "Value2")
        
        list.removeFirst()
        
        XCTAssert(list.first == "Value1")
        XCTAssert(list.last == "Value2")

        list.removeFirst()
        
        XCTAssert(list.first == "Value2")
        XCTAssert(list.last == "Value2")
        
        list.removeFirst()
        
        XCTAssert(list.first == nil)
        XCTAssert(list.last == nil)
        
        // Append values again
        
        list.append(value: "Value0")
        list.append(value: "Value1")
        list.append(value: "Value2")
        
        XCTAssert(list.first == "Value0")
        XCTAssert(list.last == "Value2")

        // Remove Last
        
        list.removeLast()
        
        XCTAssert(list.first == "Value0")
        XCTAssert(list.last == "Value1")
        
        list.removeLast()
        
        XCTAssert(list.first == "Value0")
        XCTAssert(list.last == "Value0")
        
        list.removeLast()
        
        XCTAssert(list.first == nil)
        XCTAssert(list.last == nil)
        
        // Append values again
        
        list.append(value: "Value0")
        list.append(value: "Value1")
        list.append(value: "Value2")

        XCTAssert(list.first == "Value0")
        XCTAssert(list.last == "Value2")
        
        // Remove at
        
        list.remove(at: 0)
        
        XCTAssert(list.first == "Value1")
        XCTAssert(list.last == "Value2")
        
        list.remove(at: 1)
        
        XCTAssert(list.first == "Value1")
        XCTAssert(list.last == "Value1")
        
        list.remove(at: 0)

        XCTAssert(list.first == nil)
        XCTAssert(list.last == nil)
    }
    
    func testGetSubscript()
    {
        // Append
        
        list.append(value: "Value0")
        list.append(value: "Value1")
        list.append(value: "Value2")
        list.append(value: "Value3")
        list.append(value: "Value4")
        
        XCTAssert(list[-999] == nil)
        XCTAssert(list[-1] == nil)
        XCTAssert(list[-0] == "Value0")
        XCTAssert(list[0] == "Value0")
        XCTAssert(list[1] == "Value1")
        XCTAssert(list[2] == "Value2")
        XCTAssert(list[3] == "Value3")
        XCTAssert(list[4] == "Value4")
        XCTAssert(list[5] == nil)
        XCTAssert(list[999] == nil)
        
        // Insert First
        
        list.insertFirst(value: "Value-1")
        
        XCTAssert(list[0] == "Value-1")
        XCTAssert(list[1] == "Value0")
        
        // Remove First

        list.removeFirst()
        
        XCTAssert(list[0] == "Value0")
        XCTAssert(list[1] == "Value1")
        
        // Remove Last
        
        list.removeLast()
        
        XCTAssert(list[3] == "Value3")
        XCTAssert(list[4] == nil)
    }
    
    func testSetSubscript()
    {
        // Append
        
        list.append(value: "Value0")
        list.append(value: "Value1")
        list.append(value: "Value2")
        list.append(value: "Value3")
        list.append(value: "Value4")

        // Set
        
        list[0] = "Value0-edit"
        
        XCTAssert(list.debugDescription == "[Value0-edit,Value1,Value2,Value3,Value4]")

        list[1] = "Value1-edit"
        
        XCTAssert(list.debugDescription == "[Value0-edit,Value1-edit,Value2,Value3,Value4]")

        list[4] = "Value4-edit"
        
        XCTAssert(list.debugDescription == "[Value0-edit,Value1-edit,Value2,Value3,Value4-edit]")

        list[3] = "Value3-edit"
        
        XCTAssert(list.debugDescription == "[Value0-edit,Value1-edit,Value2,Value3-edit,Value4-edit]")
        
        // Set wrong values
        
        list[-1] = "blabla"
        
        XCTAssert(list.debugDescription == "[Value0-edit,Value1-edit,Value2,Value3-edit,Value4-edit]")

        list[5] = "blabla"
        
        XCTAssert(list.debugDescription == "[Value0-edit,Value1-edit,Value2,Value3-edit,Value4-edit]")

        list[999] = "blabla"
        
        XCTAssert(list.debugDescription == "[Value0-edit,Value1-edit,Value2,Value3-edit,Value4-edit]")
        
        // Set nil
        
        list[0] = nil

        XCTAssert(list.debugDescription == "[Value1-edit,Value2,Value3-edit,Value4-edit]")

        list[1] = nil
        
        XCTAssert(list.debugDescription == "[Value1-edit,Value3-edit,Value4-edit]")

        list[2] = nil
        
        XCTAssert(list.debugDescription == "[Value1-edit,Value3-edit]")
    }
}
