//
//  LinkedList.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/11/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

private class LinkedListNode<T>
{
    typealias Node = LinkedListNode<T>
    
    var value: T
    
    var next: Node?
    weak var previous: Node?
    
    init(value: T)
    {
        self.value = value
    }
}

public struct LinkedList<T>
{
    fileprivate typealias Node = LinkedListNode<T>
    
    fileprivate var _head: Node?
    fileprivate var _tail: Node?
    
    fileprivate var _count = 0
    
    /// O(1)
    public var isEmpty: Bool {
        return _head == nil
    }
    
    /// O(1)
    public var count: Int {
        return _count
    }
    
    /// O(1)
    public var first: T? {
        return _head?.value
    }
    
    /// O(1)
    public var last: T? {
        return _tail?.value
    }
    
    /// O(1)
    public mutating func append(_ value: T)
    {
        let node = LinkedListNode(value: value)
        
        guard let last = _tail else {
            _head = node
            _tail = node
            _count = 1
            return
        }
        
        node.previous = last
        last.next = node
        
        _tail = node
        _count += 1
    }
    
    /// O(1)
    public mutating func insertFirst(_ value: T)
    {
        let node = LinkedListNode(value: value)
        
        guard let first = _head else {
            _head = node
            _tail = node
            _count = 1
            return
        }
        
        node.next = first
        first.previous = node
        _head = node
        
        _count += 1
    }
    
    /// O(1)
    public mutating func removeFirst()
    {
        guard let head = _head else { return }
        
        head.next?.previous = nil
        
        _head = head.next
        _count -= 1
        
        if _head == nil {
            _tail = nil
        }
    }
    
    /// O(1)
    public mutating func removeLast()
    {
        guard let last = _tail else { return }
        guard let previous = last.previous else {
            _head = nil
            _tail = nil
            _count = 0
            return
        }
        
        _tail = previous
        previous.next = nil
        _count -= 1
    }
    
    /// O(n) where n == index
    /// O(1) if index == 0 or index == (_count - 1) or index is out of bounds
    public mutating func remove(at index: Int)
    {
        guard index >= 0 && index < _count else { return }
        
        guard index > 0 else {
            removeFirst()
            return
        }
        
        guard index < (_count - 1) else {
            removeLast()
            return
        }
        
        var current = _head
        var count = 0
        
        while current != nil {
            if index == count {
                current!.previous?.next = current!.next
                current!.next?.previous = current!.previous
                _count -= 1
                return
            }
            
            count += 1
            current = current!.next
        }
    }
    
    /// 0(1)
    mutating func removeAll()
    {
        _head = nil
        _tail = nil
        _count = 0
    }
}

// MARK: - Collection
extension LinkedList: Collection
{
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return _count }
    
    /// O(n) where n == index
    /// O(1) if index == 0 or index == (_count - 1)
    public subscript(_ index: Int) -> T {
        get {
            guard index >= 0 && index < _count else { fatalError("Index is out of bounds") }
            
            guard index > 0 else {
                return first!
            }
            
            guard index < (_count - 1) else {
                return last!
            }
            
            var current = _head
            var count = 0
            
            while current != nil {
                if index == count {
                    return current!.value
                }
                
                count += 1
                current = current!.next
            }
            
            fatalError("Index is out of bounds")
        }
        
        set {
            guard index >= 0 && index < _count else { fatalError("Index is out of bounds") }
            
            guard index > 0 else {
                _head?.value = newValue
                return
            }
            
            guard index < (_count - 1) else {
                _tail?.value = newValue
                return
            }
            
            var current = _head
            var count = 0
            
            while current != nil {
                if index == count {
                    current!.value = newValue
                }
                
                count += 1
                current = current!.next
            }
        }
    }
    
    public func index(after i: Int) -> Int
    {
        guard i < endIndex else { fatalError("Cannot increment endIndex") }
        return i + 1
    }
}

// MARK: - String Convertible
extension LinkedList: CustomStringConvertible, CustomDebugStringConvertible
{
    public var description: String {
        var desc = "[ "
        
        var current = _head
        var count = 0
        
        while current != nil {
            if count > 0 {
                desc += ", "
            }
            
            desc += "\(current!.value)"
            current = current!.next
            count += 1
        }
        
        return desc + " ], Count: \(self.count)"
    }
    
    public var debugDescription: String {
        var desc = "["
        
        var current = _head
        var count = 0
        
        while current != nil {
            if count > 0 {
                desc += ","
            }
            
            desc += "\(current!.value)"
            current = current!.next
            count += 1
        }
        
        return desc + "]"
    }
}
