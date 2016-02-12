//
//  Dynamic.swift
//  Swiftility
//
//  Created by Allan Barbato on 9/9/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

public struct Dynamic<T>
{
    public typealias Listener = T -> Void

    // MARK: - Private

    private var _listener: Listener?
    
    // MARK: - Properties
    
    /// Contained value. Changes fire listener if `self.shouldFire == true`
    public var value: T {
        didSet {
            guard shouldFire == true else { return }
            
            self.fire()
        }
    }

    /// Whether value didSet should fire or not
    public var shouldFire: Bool = true
    
    /// Whether fire() should call listener on main thread or not
    public var fireOnMainThread: Bool = true
    
    // Has a listener
    public var isBinded: Bool {
        return _listener != nil
    }
    
    // MARK: - Life cycle

    /// Init with a value
    public init(_ v: T)
    {
        value = v
    }

    // MARK: - Binding

    /**
    Bind a listener to value changes
    
    - parameter listener: Closure called when value changes
    */
    public mutating func bind(listener: Listener?)
    {
        _listener = listener
    }

    /**
     Same as `bind` but also fires immediately
     
     - parameter listener: Closure called immediately and when value changes
     */
    public mutating func bindAndFire(listener: Listener?)
    {
        self.bind(listener)
        self.fire()
    }
    
    // MARK: - Actions
    
    // Fires listener if not nil. Regardless of `self.shouldFire`
    public func fire()
    {
        if fireOnMainThread {
            dispatch_async(dispatch_get_main_queue(), {
                self._listener?(self.value)
            })
        } else {
            self._listener?(self.value)
        }
    }
    
    /**
     Set value with optional firing. Regardless of `self.shouldFire`
     
     - parameter value: Value to update to
     - parameter =true;fire:  Should fire changes of value
     */
    public mutating func setValue(value: T, fire: Bool = true)
    {
        let originalShouldFire = shouldFire
        
        shouldFire = fire
        self.value = value
        shouldFire = originalShouldFire
    }
}