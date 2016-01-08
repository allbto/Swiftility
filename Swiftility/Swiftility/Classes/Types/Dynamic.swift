//
//  Dynamic.swift
//  RxTest
//
//  Created by Allan Barbato on 9/9/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

public struct Dynamic<T>
{
    // MARK: - Properties
    
    private var listener: Listener?

    public typealias Listener = T -> Void
    
    public var shouldFire: Bool = true
    
    public var value: T {
        didSet {
            self.fire()
        }
    }
    
    public var isBinded: Bool {
        return self.listener != nil
    }
    
    // MARK: - Life cycle
    
    public init(_ v: T)
    {
        value = v
    }

    // MARK: - Binding
    
    public mutating func bind(listener: Listener?)
    {
        self.listener = listener
    }
    
    public mutating func bindAndFire(listener: Listener?)
    {
        self.listener = listener
        self.fire()
    }
    
    // MARK: - Actions
    
    public func fire()
    {
        guard shouldFire == true else { return }
        
        dispatch_async(dispatch_get_main_queue(), {
            self.listener?(self.value)
        })
    }
    
    public mutating func setValue(value: T, fire: Bool = true)
    {
        let originalShouldFire = shouldFire
        
        shouldFire = fire
        self.value = value
        shouldFire = originalShouldFire
    }
}