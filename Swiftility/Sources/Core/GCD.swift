//
//  GCD.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/23/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

public typealias DispatchClosure = () -> Void

// TODO: Tests

// MARK: - Async

/// Convenience call to dispatch_async
public func async(queue: DispatchQueue = .global(qos: .background), execute closure: @escaping DispatchClosure)
{
    queue.async(execute: closure)
}

/// Convenience call to async(queue: .main)
public func async_main(_ closure: @escaping DispatchClosure)
{
    async(queue: .main, execute: closure)
}

// MARK: - After / Delay

/// Convenience call to dispatch_after (time is in seconds)
public func after(_ delay: TimeInterval, queue: DispatchQueue = .main, execute closure: @escaping DispatchClosure)
{
    queue.asyncAfter(
        deadline: .now() + delay,
        execute: closure
    )
}

/// Same as after
public func delay(_ delay: TimeInterval, queue: DispatchQueue = .main, execute closure: @escaping DispatchClosure)
{
    after(delay, queue: queue, execute: closure)
}

// MARK: - Once

fileprivate extension DispatchQueue
{
    static var _onceTracker = [String]()
}

/**
 Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
 only execute the code once even in the presence of multithreaded calls.
 
 - parameter token:     A unique reverse DNS style name such as com.vectorform.<name> or a GUID
 - parameter execute:   Closure to execute once
 */
public func once(token: String, execute closure: DispatchClosure)
{
    objc_sync_enter(DispatchQueue.self); defer { objc_sync_exit(DispatchQueue.self) }
    
    if DispatchQueue._onceTracker.contains(token) {
        return
    }
    
    DispatchQueue._onceTracker.append(token)
    closure()
}


// MARK: - Debounce

/**
 Debounce will fire method when delay passed, but if there was request before that, then it invalidates the previous method and uses only the last
 
 - parameter delay:  delay before each debounce
 - parameter queue:  =.main; Queue to fire to
 - parameter action: closure called when debouncing
 
 - returns: closure to call to fire the debouncing
 */
public func debounce<T>(_ delay: TimeInterval, queue: DispatchQueue = .main, action: @escaping (T) -> Void) -> (T) -> Void
{
    var lastCall: Int = 0
    
    return { t in
        // Increase call counter and invalidate the call if it is not the last one
        lastCall += 1
        let currentCall = lastCall
        queue.asyncAfter(
            deadline: .now() + delay,
            execute: {
                if lastCall == currentCall {
                    action(t)
                }
            }
        )
    }
}

