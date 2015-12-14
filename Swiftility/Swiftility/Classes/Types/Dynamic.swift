//
//  Dynamic.swift
//  RxTest
//
//  Created by Allan Barbato on 9/9/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

public struct Dynamic<T> {
    public typealias Listener = T -> Void
    var listener: Listener?
    
    public mutating func bind(listener: Listener?) {
        self.listener = listener
    }
    
    public mutating func bindAndFire(listener: Listener?) {
        self.listener = listener
        self.fire()
    }
    
    public func fire() {
        dispatch_async(dispatch_get_main_queue(), {
            self.listener?(self.value)
        })
    }
    
    public var value: T {
        didSet {
            self.fire()
        }
    }
    
    public var isBinded: Bool {
        return self.listener != nil
    }
    
    public init(_ v: T) {
        value = v
    }
}