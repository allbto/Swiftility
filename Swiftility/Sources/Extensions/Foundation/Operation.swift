//
//  Operation.swift
//  Swiftility
//
//  Created by Allan Barbato on 12/22/16.
//  Copyright © 2016 Allan Barbato. All rights reserved.
//

import Foundation

open class ConcurrentOperation: Operation
{
    override open var isAsynchronous: Bool {
        return true
    }
    
    private var _executing = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    override open var isExecuting: Bool {
        return _executing
    }
    
    private var _finished = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override open var isFinished: Bool {
        return _finished
    }
    
    override open func start()
    {
        _executing = true
        execute()
    }
    
    open func execute()
    {
        // Execute your async task here.
    }
    
    open func finish()
    {
        _executing = false
        _finished = true
    }
}
