//
//  GCD.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/23/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

public typealias DispatchClosure = () -> Void


// MARK: - Async

/// Convenience call to dispatch_async
public func async(queue: DispatchQueue = .global(qos: .background), closure: @escaping DispatchClosure)
{
    queue.async(execute: closure)
}

/// Convenience call to async(queue: .main)
public func async_main(_ closure: @escaping DispatchClosure)
{
    async(queue: .main, closure: closure)
}

/// Convenience call to dispatch_after (time is in seconds)
public func after(_ delay: TimeInterval, queue: DispatchQueue = .main, closure: @escaping DispatchClosure)
{
    queue.asyncAfter(
        deadline: .now() + delay,
        execute: closure
    )
}

/// Same as after
public func delay(_ delay: TimeInterval, queue: DispatchQueue = .main, closure: @escaping DispatchClosure)
{
    after(delay, queue: queue, closure: closure)
}

// MARK: - Debounce / Throttle

// TODO: Tests

/**
 Debounce will fire method when delay passed, but if there was request before that, then it invalidates the previous method and uses only the last
 
 - parameter delay:  delay before each debounce
 - parameter queue:  =.Main; Queue to fire to
 - parameter action: closure called when debouncing
 
 - returns: closure to call to fire the debouncing
 */
public func debounce<T>(_ delay: TimeInterval, queue: DispatchQueue = .main, action: @escaping (T) -> Void) -> (T) -> Void
{
    var lastCall : Int = 0
    
    return { t in
        // Increase call counter and invalidate the call if it is not the last one
        lastCall += 1
        let currentCall = lastCall
        queue.asyncAfter(
            deadline: .now() + delay) {
                if lastCall == currentCall {
                    action(t)
                }
        }
    }
}

