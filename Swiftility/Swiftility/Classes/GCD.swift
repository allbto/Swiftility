//
//  GCD.swift
//  Swiftility
//
//  Created by Allan Barbato on 10/23/15.
//  Copyright © 2015 Allan Barbato. All rights reserved.
//

import Foundation

public typealias DispatchClosure = dispatch_block_t
public typealias DispatchQueue = dispatch_queue_t

public enum GCDQueue
{
    case Main
    case High
    case Default
    case Low
    case Background
    case Custom(DispatchQueue)
    
    var queue: DispatchQueue {
        switch self {
        case .Main:
            return dispatch_get_main_queue()
        case .High:
            return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
        case .Default:
            return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        case .Low:
            return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)
        case .Background:
            return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
        case .Custom(let queue):
            return queue
        }
    }
}

// MARK: - Async

/// Convenience call to dispatch_async
public func async(queue: GCDQueue = .Default, closure: DispatchClosure)
{
    dispatch_async(queue.queue, closure)
}

/// Convenience call to async(.Main)
public func async_main(closure: DispatchClosure)
{
    async(.Main, closure: closure)
}

/// Convenience call to dispatch_after (time is in seconds)
public func after(delay: Double, queue: GCDQueue = .Main, closure: DispatchClosure)
{
    let dispatchDelay = Int64(delay * Double(NSEC_PER_SEC))

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, dispatchDelay), queue.queue, closure)
}

// MARK: - Debounce / Throttle

/**
 Debounce will fire method when delay passed, but if there was request before that, then it invalidates the previous method and uses only the last

- parameter delay:  delay before each debounce
- parameter queue:  =.Main; Queue to fire to
- parameter action: closure called when debouncing

- returns: closure to call to fire the debouncing
*/
public func debounce(delay: NSTimeInterval, queue: GCDQueue = .Main, action: DispatchClosure) -> DispatchClosure
{
    var lastCall : Int = 0
    let dispatchDelay = Int64(delay * Double(NSEC_PER_SEC))
    
    return {
        // Increase call counter and invalidate the call if it is not the last one
        lastCall++
        let currentCall = lastCall
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                dispatchDelay
            ),
            queue.queue) {
                if lastCall == currentCall {
                    action()
                }
        }
    }
}

/**
 Throttled method will be fired only if some time passed after you called it before
 
 - parameter delay:  delay before each throttle
 - parameter queue:  =.Main; Queue to fire to
 - parameter action: closure called when throttling
 
 - returns: closure to call to fire the throttleing
 */
public func throttle(delay: NSTimeInterval, queue: GCDQueue = .Main, action: DispatchClosure) -> DispatchClosure
{
    var lastFireTime : dispatch_time_t = 0
    let dispatchDelay = Int64(delay * Double(NSEC_PER_SEC))
    
    return {
        lastFireTime = dispatch_time(DISPATCH_TIME_NOW,0)
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                dispatchDelay
            ),
            queue.queue) {
                let now = dispatch_time(DISPATCH_TIME_NOW,0)
                let when = dispatch_time(lastFireTime, dispatchDelay)
                if now >= when {
                    action()
                }
        }
    }
}

